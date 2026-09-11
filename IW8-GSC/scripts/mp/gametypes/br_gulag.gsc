
// Params 0
// Size: 0x44b
function initgulag()
{
    level.ref_12ca0 = getdvarfloat( "scr_br_respawn_circleInterpPct", 0.75 );
    
    if ( !istrue( level.usegulag ) )
    {
        return;
    }
    
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "gulag" ) )
    {
        level.usegulag = 0;
        return;
    }
    
    setomnvar( "ui_gulag_state", 1 );
    setomnvar( "ui_gulag_show_closing_state", 0 );
    level.gulag = spawnstruct();
    level.gulag.arenaflag = getdvarint( "scr_br_fc_flag", 1 );
    level.gulag.maxplayers = getmaxplayers();
    level.gulag.maxuses = getdvarint( "scr_br_fc_max_uses", 1 );
    level.gulag.endonshutdown = getdvarint( "scr_br_fc_end_on_shutdown", 3 );
    level.gulag.timelimit = getdvarint( "scr_br_fc_timelimit", 15 );
    level.gulag.maxqueue = getdvarint( "scr_br_fc_max_queue_wait", 3 );
    level.gulag.onekillwin = getdvarint( "scr_br_fc_one_kill_win", 1 );
    level.gulag.multiarena = getdvarint( "scr_br_fc_multi_arena", 1 );
    level.gulag.planerespawn = getdvarint( "scr_br_fc_plane_respawn", 0 );
    level.gulag.trial_target_civilian_killed_func = getdvarint( "scr_br_fc_intro_cinematic", 1 );
    level.gulag.ref_14069 = getdvarint( "scr_br_fc_useCellSpawns", 1 );
    level.gulag.ref_1407f = getdvarint( "scr_br_fc_useFloorRocks", 0 );
    level.gulag.ref_13672 = getdvarint( "scr_br_fc_spawnLoot", 0 );
    level.gulag.lethaldelay = getdvarint( "scr_br_fc_lethalDelay", 4 );
    level.gulag.ref_1391b = getdvarint( "scr_br_fc_prestream_geo_timeout", 9 );
    level.gulag.ref_11f2d = getdvarint( "scr_br_fc_numArmorHealth", 0 );
    level.gulag.ref_11f19 = getdvarint( "scr_br_gulag_nuketown", 0 );
    level.gulag.untrack_enemy = getdvarint( "scr_br_gulag_island", 0 );
    level.gulag.impairedkill = getdvarint( "scr_br_fc_countdownTime", 3 );
    level.gulag.juggheli_spawner_jammer5_2 = getdvarint( "scr_br_fc_defaultPlunder", 5 );
    level.gulag.getaccessorylogicbyindex = getdvarint( "scr_br_gulag_chair", 0 );
    level.gulag.ref_142fb = getdvarint( "scr_br_gulag_voices", 1 );
    level.gulag.Ü^+ ¡_√p@âúh∏_%wÿr„XÖSøà∏çé˝ = getdvarint( "scr_redeployToken_convertAmount", 40 );
    level.gulag.ãTd≠kÒ/˚®–‚÷«ËÎ%ve7xC%ì = getdvarint( "scr_gulagToken_convertAmount", 20 );
    level.gulag.ëD¢bgÌ—»Ω#˘;≥00E+;	“ = getdvarint( "scr_tokenConversion_messageDisplayTime", 5 );
    _setdomflagiconinfo( "waypoint_captureneutral", "neutral", "MP_BR_INGAME/DOM_CAPTURE", 0 );
    _setdomflagiconinfo( "waypoint_capture", "enemy", "MP_BR_INGAME/DOM_CAPTURE", 0 );
    _setdomflagiconinfo( "waypoint_defend", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", 0 );
    _setdomflagiconinfo( "waypoint_defending", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", 0 );
    _setdomflagiconinfo( "waypoint_contested", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", 1 );
    _setdomflagiconinfo( "waypoint_taking", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", 1 );
    _setdomflagiconinfo( "waypoint_losing", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", 1 );
    level.gulag.watch_for_near_objective_point = [];
    
    if ( istrue( level.gulag.arenaflag ) )
    {
        scripts\mp\gametypes\br_dom_quest::ref_13239();
    }
    
    level.gulag.arenas = gulaggetarenas();
    gulaggesturesinit();
    gulaginitloadouts();
    
    if ( level.gulag.trial_target_civilian_killed_func )
    {
        scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback( &ref_12521 );
    }
    
    if ( level.gulag.ref_1407f )
    {
        scripts\engine\scriptable::ref_12f5b( "brloot_rock", &rockused );
    }
    
    level.gulag.betting = getdvarint( "scr_br_fc_betting", 0 );
    
    if ( level.gulag.betting )
    {
        if ( !istrue( level.br_plunder_enabled ) )
        {
            level.gulag.betting = 0;
        }
        
        if ( getdvarint( "scr_br_fc_countdownTime", 3 ) == 3 )
        {
            level.gulag.impairedkill = 15;
        }
    }
    
    if ( !isdefined( level.gulag.arenas[ 0 ].jailspawns[ 0 ].chair ) )
    {
        level.gulag.getaccessorylogicbyindex = 0;
    }
    
    foreach ( var1 in level.gulag.arenas )
    {
        thread monitorgulag( level );
    }
    
    thread spawnac130();
    tracegroundheightexfil();
    level.playerzombieupdateongamepadchange = &ref_12aa8;
    level.playimpactfx = &ref_12aaa;
}

// Params 4
// Size: 0x39
function _setdomflagiconinfo( var0, var1, var2, var3 )
{
    level.waypointcolors[ var0 ] = var1;
    level.waypointbgtype[ var0 ] = 1;
    level.waypointstring[ var0 ] = var2;
    level.waypointshader[ var0 ] = "ui_mp_br_mapmenu_icon_gulag_overtime_objective";
    level.waypointpulses[ var0 ] = var3;
}

// Params 0
// Size: 0x132
function tracegroundheightexfil()
{
    game[ "dialog" ][ "gulag_spawn" ] = "gulag_spawn";
    game[ "dialog" ][ "gulag_spawn_rules" ] = "gulag_spawn_rules";
    game[ "dialog" ][ "gulag_objective" ] = "gulag_objective";
    game[ "dialog" ][ "gulag_next" ] = "gulag_next";
    game[ "dialog" ][ "gulag_win" ] = "gulag_win";
    game[ "dialog" ][ "gulag_lose" ] = "gulag_lose";
    game[ "dialog" ][ "gulag_teammate_gulag" ] = "gulag_teammate_gulag";
    game[ "dialog" ][ "gulag_teammate_lose" ] = "gulag_teammate_lose";
    game[ "dialog" ][ "gulag_teammate_win" ] = "gulag_teammate_win";
    game[ "dialog" ][ "gulag_gulag_active" ] = "gulag_gulag_active";
    game[ "dialog" ][ "gulag_gulag_close" ] = "gulag_gulag_close";
    game[ "dialog" ][ "gulag_noenemy" ] = "gulag_noenemy";
    game[ "dialog" ][ "gulag_timeout" ] = "gulag_timeout";
    game[ "dialog" ][ "gulag_buyback" ] = "gulag_buyback";
    game[ "dialog" ][ "gulag_taunt" ] = "gulag_taunt";
    game[ "dialog" ][ "gulag_obj_wait" ] = "gulag_obj_wait";
}

// Params 0
// Size: 0x48
function gulaggetarenas()
{
    var0 = relic_steelballs_dash();
    
    if ( scripts\mp\gametypes\br_public::tutorial_playsound() )
    {
        var0 = scripts\engine\utility::getstructarray( "gulag_tutorial", "targetname" );
    }
    
    for ( var1 = 0; var1 < var0.size ; var1++ )
    {
        var2 = var0[ var1 ];
        var2.set_relic_oneclip = var1;
        setuparena( var2 );
    }
    
    return var0;
}

// Params 0
// Size: 0x9e
function relic_steelballs_dash()
{
    var0 = scripts\engine\utility::getstructarray( "gulag", "targetname" );
    var1 = [];
    
    foreach ( var3 in var0 )
    {
        var4 = isdefined( var3.script_noteworthy ) && var3.script_noteworthy == "nuketown";
        
        if ( istrue( level.gulag.ref_11f19 ) && var4 || !istrue( level.gulag.ref_11f19 ) && !var4 )
        {
            var1 = var3;
        }
    }
    
    if ( var1.size > 0 )
    {
        var0 = var1;
    }
    
    if ( var0.size > 1 )
    {
        var0 = scripts\engine\utility::array_randomize( var0 );
    }
    
    return var0;
}

// Params 1
// Size: 0x2fc
function setuparena( var0 )
{
    var0.jailspawns = [];
    var0.fightspawns = [];
    var0.get_wave_spawn_total = [];
    var0.gates = [];
    var0.floor = [];
    var0.weapons = [];
    var0.molotovs = [];
    var0.ref_13b29 = [];
    var0.getactiveteamcount = [];
    var0.ref_12d93 = [];
    var0.jailedplayers = [];
    var0.arenaplayers = [];
    var0.matches = [];
    var0.loadingplayers = [];
    var0.fightover = 1;
    var0.ref_11fcf = [];
    var0.ref_11fcf[ "ui_br_gulag_players_1" ] = 0;
    var0.ref_11fcf[ "ui_br_gulag_data" ] = 0;
    var1 = [];
    var2 = scripts\engine\utility::getstructarray( var0.target, "targetname" );
    
    foreach ( var4 in var2 )
    {
        if ( var4.script_noteworthy == "prison_spawn" )
        {
            var0.jailspawns[ var0.jailspawns.size ] = var4;
            continue;
        }
        
        if ( var4.script_noteworthy == "fight_spawn" )
        {
            var0.fightspawns[ var0.fightspawns.size ] = var4;
            continue;
        }
        
        if ( var4.script_noteworthy == "cell_spawn" )
        {
            var0.get_wave_spawn_total[ var0.get_wave_spawn_total.size ] = var4;
            continue;
        }
        
        if ( var4.script_noteworthy == "gulag_center" )
        {
            var0.center = var4.origin;
            continue;
        }
        
        if ( var4.script_noteworthy == "spectator" )
        {
            var0.ref_136dc = var4;
            continue;
        }
        
        if ( isdefined( var4.script_parameters ) && var4.script_parameters == "gulag_loot" )
        {
            var1 = var4;
            continue;
        }
        
        if ( var4.script_noteworthy == "voices" )
        {
            var0.ref_12d93[ var0.ref_12d93.size ] = var4;
        }
    }
    
    if ( !isdefined( var0.center ) )
    {
        var0.center = getgulagcenter( var0 );
    }
    
    if ( getdvarint( "scr_br_fc_shifted_spawns", 1 ) > 0 )
    {
        var0.fightspawns = scripts\engine\utility::array_sort_with_func( var0.fightspawns, &hidequestobjiconfromplayer );
    }
    else
    {
        var0.fightspawns = scripts\engine\utility::array_sort_with_func( var0.fightspawns, &hiderespawntimer );
    }
    
    foreach ( var7 in var0.get_wave_spawn_total )
    {
        ref_1322e( var0, var7 );
    }
    
    var0.get_wave_spawn_total = scripts\engine\utility::array_sort_with_func( var0.get_wave_spawn_total, &hiderespawntimer );
    
    foreach ( var10 in var0.jailspawns )
    {
        ref_13255( var0, var10 );
    }
    
    if ( istrue( level.gulag.ref_13672 ) )
    {
        var0.weapons = spawnlootweapons( var1 );
    }
    
    spawnrocks( var0 );
    
    if ( istrue( level.gulag.arenaflag ) )
    {
        ref_1323a( var0 );
        return;
    }
}

// Params 0
// Size: 0xd4
function gulaggesturesinit()
{
    level.gulag.gestures_enabled = getdvarint( "scr_br_fc_gestures", 0 );
    
    if ( !istrue( level.gulag.gestures_enabled ) )
    {
        return;
    }
    
    level.gulag.gestures = [];
    level.gulag.gestures[ "fc_gesture_neg" ] = [ "iw8_ges_plyr_gesture_crush", "iw8_ges_plyr_gesture_rally", "iw8_ges_plyr_gesture_revive" ];
    level.gulag.gestures[ "fc_gesture_pos" ] = [ "iw8_ges_plyr_gesture_doubletime", "iw8_ges_plyr_gesture_hold", "iw8_ges_plyr_gesture_ok", "iw8_ges_plyr_gesture_thumbs_up" ];
    level.gulag.gesturesounds[ "fc_gesture_neg" ] = [ "tmp_gulag_gesture_neg_crush", "tmp_gulag_gesture_neg_rally", "tmp_gulag_gesture_neg_revive" ];
    level.gulag.gesturesounds[ "fc_gesture_pos" ] = [ "tmp_gulag_gesture_pos_doubletime", "tmp_gulag_gesture_pos_hold", "tmp_gulag_gesture_pos_ok", "tmp_gulag_gesture_pos_thumbs_up" ];
}

// Params 0
// Size: 0x28
function getmaxplayers()
{
    var0 = int( clamp( getdvarint( "scr_br_fc_max_players", 2 ), 2, 2 ) );
    
    if ( var0 % 2 != 0 )
    {
        var0 -= 1;
    }
    
    return var0;
}

// Params 2
// Size: 0x15, Type: bool
function hiderespawntimer( var0, var1 )
{
    return var0.script_index < var1.script_index;
}

// Params 2
// Size: 0x5a, Type: bool
function hidequestobjiconfromplayer( var0, var1 )
{
    if ( var0.script_index == 4 )
    {
        return true;
    }
    else if ( var0.script_index == 5 )
    {
        return true;
    }
    else if ( var1.script_index == 4 )
    {
        return false;
    }
    else if ( var1.script_index == 5 )
    {
        return false;
    }
    
    return hiderespawntimer( var0, var1 );
}

// Params 3
// Size: 0x36
function copystructwithoffset( var0, var1, var2 )
{
    var3 = spawnstruct();
    var3.origin = var0.origin + var1;
    var3.angles = var0.angles;
    var3.script_index = var2;
    return var3;
}

// Params 1
// Size: 0x53
function getgulagcenter( var0 )
{
    var1 = ( 0, 0, 0 );
    
    foreach ( var3 in var0.fightspawns )
    {
        var1 += var3.origin;
    }
    
    var1 /= var0.fightspawns.size;
    return var1;
}

// Params 3
// Size: 0x48
function spawnweapon( var0, var1, var2 )
{
    var3 = scripts\mp\gametypes\br_weapons::createspawnweaponatpos( getgroundposition( var0.origin + ( 0, 0, 12 ), 12 ), var0.angles + ( 0, 0, 90 ), var1, [] );
    thread outlinewatchplayerprox( var3 );
    return var3;
}

// Params 1
// Size: 0x23b
function spawnlootweapons( var0 )
{
    var1 = [];
    var2 = [];
    GscBinSkip0( 0x2e, "none", [ "none" ] );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 1
// Size: 0x5a, Type: bool
function ref_125ee( var0 )
{
    if ( ref_125ef( var0 ) )
    {
        var1 = var0.matches[ 0 ];
        
        foreach ( var3 in var1 )
        {
            if ( var3 == self )
            {
                continue;
            }
            
            if ( updatelootleadercirclesize( var3, var0 ) )
            {
                return false;
            }
        }
        
        return true;
    }
    
    return false;
}

// Params 1
// Size: 0x46, Type: bool
function ref_125ef( var0 )
{
    if ( ismatchpending( var0 ) )
    {
        var1 = var0.matches[ 0 ];
        
        foreach ( var3 in var1 )
        {
            if ( var3 == self )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Params 1
// Size: 0x2b, Type: bool
function ismatchpending( var0 )
{
    if ( var0.matches.size == 0 )
    {
        return false;
    }
    
    var1 = var0.matches[ 0 ];
    
    if ( var1.size < 2 )
    {
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0x57, Type: bool
function isfightready( var0 )
{
    if ( !ismatchpending( var0 ) )
    {
        return false;
    }
    
    var1 = var0.matches[ 0 ];
    
    foreach ( var3 in var1 )
    {
        if ( istrue( var3.entergulagwait ) || !istrue( var3.jailed ) )
        {
            return false;
        }
    }
    
    return true;
}

// Params 1
// Size: 0xd6
function set_relic_noregen( var0 )
{
    var1 = 5000;
    
    if ( !isdefined( var0.ref_11e78 ) )
    {
        var0.ref_11e78 = gettime() + var1;
        return;
    }
    
    if ( gettime() > var0.ref_11e78 )
    {
        var0.jailedplayers = scripts\engine\utility::array_removeundefined( var0.jailedplayers );
        updatematchqueuepositions( var0 );
        
        if ( var0.set_relic_oneclip == 0 )
        {
            level.gulag.watch_for_near_objective_point = scripts\engine\utility::array_removeundefined( level.gulag.watch_for_near_objective_point );
            
            foreach ( var3 in level.gulag.watch_for_near_objective_point )
            {
                if ( !istrue( var3.inlaststand ) )
                {
                    level.gulag.watch_for_near_objective_point = scripts\engine\utility::array_remove( level.gulag.watch_for_near_objective_point, var3 );
                }
            }
        }
        
        var0.ref_11e78 = gettime() + var1;
        return;
    }
}

// Params 1
// Size: 0x16c
function monitorgulag( var0 )
{
    level endon( "game_ended" );
    var1 = relic_amped_paused();
    
    for ( ;; )
    {
        set_relic_noregen( var0 );
        
        if ( istrue( level.br_prematchstarted ) )
        {
            if ( istrue( level.gulag.shutdown ) )
            {
                if ( var0.loadingplayers.size != 0 )
                {
                    var0 scripts\engine\utility::waittill_notify_or_timeout( "loadingPlayersEmpty", var1 );
                }
                
                if ( level.gulag.endonshutdown == 1 )
                {
                    foreach ( var3 in var0.jailedplayers )
                    {
                        var3.gulagloser = 1;
                        var3 kill();
                    }
                    
                    var0.shutdown = 1;
                }
                else if ( level.gulag.endonshutdown == 2 )
                {
                    thread dojailbreak( var0 );
                }
                else if ( level.gulag.endonshutdown == 3 && ( istrue( var0.shutdown ) || !ismatchpending( var0 ) && !c130airdrop_getteamaveragepos() ) )
                {
                    foreach ( var3 in var0.jailedplayers )
                    {
                        if ( isalive( var3 ) )
                        {
                            playergulagarenaready( var3 );
                            thread gulagvictory( var0, var3, 1, 0, "shutdown" );
                        }
                    }
                    
                    var0.shutdown = 1;
                }
            }
            
            if ( unset_relic_martyrdom() )
            {
                waitframe();
                continue;
            }
            
            if ( isfightready( var0 ) )
            {
                beginnewfight( var0 );
            }
            else
            {
                ref_13165( var0 );
            }
        }
        
        waitframe();
    }
}

// Params 1
// Size: 0x1b
function ref_12219( var0 )
{
    if ( !istrue( level.usegulag ) )
    {
        return;
    }
    
    level.gulag.paused = var0;
}

// Params 0
// Size: 0x19, Type: bool
function unset_relic_martyrdom()
{
    return istrue( level.usegulag ) && istrue( level.gulag.paused );
}

// Params 0
// Size: 0x47, Type: bool
function calloutmarkerping_cp_setupcptimeouts()
{
    if ( !istrue( level.usegulag ) )
    {
        return false;
    }
    
    foreach ( var1 in level.gulag.arenas )
    {
        if ( !var1.fightover )
        {
            return true;
        }
    }
    
    return false;
}

// Params 0
// Size: 0x25
function vehicle_compass_cp_shouldbevisibletoplayer()
{
    if ( isdefined( self ) && isalive( self ) )
    {
        gulagvictory( self.arena, self, 1, 1, "jailbreakEvent" );
        return;
    }
}

// Params 1
// Size: 0x37
function circletimer( var0 )
{
    if ( istrue( level.usegulag ) && !istrue( level.gulag.shutdown ) )
    {
        var1 = remove_engineer_class();
        
        if ( var0 >= var1 )
        {
            shutdowngulag( "circle_index", var0 );
            return;
        }
        
        return;
    }
}

// Params 3
// Size: 0xff
function shutdowngulag( var0, var1, var2 )
{
    if ( !istrue( level.usegulag ) || istrue( level.gulag.shutdown ) )
    {
        return;
    }
    
    setomnvar( "ui_gulag_state", 0 );
    setomnvar( "ui_gulag_show_closing_state", 2 );
    level.gulag.shutdown = 1;
    
    if ( isdefined( level.ref_12851 ) )
    {
        [[ level.ref_12851 ]]();
    }
    
    thread makeac130flyaway();
    
    if ( !istrue( var2 ) )
    {
        foreach ( var4 in level.players )
        {
            resolvetokensongulagshutdown( var4 );
            
            if ( istrue( var4.inlaststand ) )
            {
                level.gulag.watch_for_near_objective_point[ level.gulag.watch_for_near_objective_point.size ] = var4;
                continue;
            }
            
            if ( !isdefined( var4 ) || !isalive( var4 ) || isdefined( var4.gulag ) )
            {
                continue;
            }
            
            playergulagdonesplash( var4 );
            updatecanusegulag( var4 );
        }
    }
    
    getentitylessscriptablearray( "dlog_event_br_gulag_shutdown", [ "reason", var0, "reason_count", var1 ] );
}

// Params 0
// Size: 0x12b
function resolvetokensongulagshutdown()
{
    var0 = 0;
    var1 = 0;
    
    if ( istrue( level.br_pickups.ref_12cb5 ) && scripts\mp\gametypes\br_public::hasrespawntoken() && level.gulag.Ü^+ ¡_√p@âúh∏_%wÿr„XÖSøà∏çé˝ > 0 )
    {
        var0 = 1;
        scripts\mp\gametypes\br_pickups::removerespawntoken();
        scripts\mp\gametypes\br_plunder::ref_12627( level.gulag.Ü^+ ¡_√p@âúh∏_%wÿr„XÖSøà∏çé˝ );
    }
    
    if ( istrue( level.br_pickups.ôÌR«ÇS‰Û»ØbH7»®c£wó„cπ˚ ) && scripts\mp\gametypes\br_public::hasgulagtoken() && level.gulag.ãTd≠kÒ/˚®–‚÷«ËÎ%ve7xC%ì > 0 )
    {
        var1 = 1;
        scripts\mp\gametypes\br_pickups::removegulagtoken();
        scripts\mp\gametypes\br_plunder::ref_12627( level.gulag.ãTd≠kÒ/˚®–‚÷«ËÎ%ve7xC%ì );
    }
    else if ( istrue( level.br_pickups.ôÌR«ÇS‰Û»ØbH7»®c£wó„cπ˚ ) && checkgulagusecount() && level.gulag.ãTd≠kÒ/˚®–‚÷«ËÎ%ve7xC%ì > 0 )
    {
        var1 = 1;
        scripts\mp\gametypes\br_plunder::ref_12627( level.gulag.ãTd≠kÒ/˚®–‚÷«ËÎ%ve7xC%ì );
    }
    
    if ( var0 && var1 )
    {
        scripts\mp\utility\lower_message::ref_1316e( "br_redeployGulag_conversion", undefined, level.gulag.ëD¢bgÌ—»Ω#˘;≥00E+;	“ );
    }
    else if ( var0 )
    {
        scripts\mp\utility\lower_message::ref_1316e( "br_redeploy_conversion", undefined, level.gulag.ëD¢bgÌ—»Ω#˘;≥00E+;	“ );
    }
    else if ( var1 )
    {
        scripts\mp\utility\lower_message::ref_1316e( "br_gulag_conversion", undefined, level.gulag.ëD¢bgÌ—»Ω#˘;≥00E+;	“ );
    }
    
    hidealltokensongulagshutdown();
}

// Params 0
// Size: 0x74
function hidealltokensongulagshutdown()
{
    var0 = getlootscriptablearrayinradius( "brloot_redeploy_token", undefined );
    var1 = getlootscriptablearrayinradius( "brloot_gulag_token", undefined );
    
    foreach ( var3 in var0 )
    {
        scripts\mp\gametypes\br_pickups::ref_11a21( var3 );
    }
    
    foreach ( var3 in var1 )
    {
        scripts\mp\gametypes\br_pickups::ref_11a21( var3 );
    }
    
    level.br_pickups.¨⁄Ü•ë¨G{[YÊ7 = 1;
}

// Params 0
// Size: 0x11, Type: bool
function c130airdrop_getteamaveragepos()
{
    return level.gulag.watch_for_near_objective_point.size > 0;
}

// Params 0
// Size: 0x30
function ref_125e6()
{
    if ( !istrue( level.usegulag ) || !istrue( level.gulag.shutdown ) )
    {
        return 0;
    }
    
    return scripts\engine\utility::array_contains( level.gulag.watch_for_near_objective_point, self );
}

// Params 1
// Size: 0x6d, Type: bool
function set_relic_steelballs( var0 )
{
    if ( istrue( level.gulag.shutdown ) && c130airdrop_getteamaveragepos() )
    {
        if ( isdefined( var0 ) && ref_125e6( var0 ) )
        {
            level.gulag.watch_for_near_objective_point = scripts\engine\utility::array_remove( level.gulag.watch_for_near_objective_point, var0 );
            return true;
        }
        else
        {
            level.gulag.watch_for_near_objective_point = scripts\engine\utility::array_removeundefined( level.gulag.watch_for_near_objective_point );
        }
    }
    
    return false;
}

// Params 1
// Size: 0x15
function onplayerdisconnect( var0 )
{
    if ( !istrue( level.usegulag ) )
    {
        return;
    }
    
    set_relic_steelballs( var0 );
}

// Params 1
// Size: 0x29
function ref_12551( var0 )
{
    if ( !istrue( level.usegulag ) )
    {
        return;
    }
    
    if ( istrue( var0 ) )
    {
        self.watch_for_driver_death = undefined;
        
        if ( set_relic_steelballs( self ) )
        {
            playergulagdonesplash();
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x4f
function remove_engineer_class()
{
    if ( !isdefined( level.br_level ) || !isdefined( level.br_level.br_circledelaytimes ) )
    {
        return 0;
    }
    
    var0 = level.br_level.delay_start_infiltrate_objective;
    
    if ( !isdefined( var0 ) )
    {
        var0 = 0;
    }
    
    return level.br_level.br_circledelaytimes.size - 1 - getdvarint( "scr_br_fc_circle_disable", 3 ) - var0;
}

// Params 0
// Size: 0x24
function ref_13249()
{
    var0 = run_hud_logic();
    var1 = gettime() + var0 * 1000;
    setomnvar( "ui_gulag_timer", var1 );
    thread ref_13346( var0 );
}

// Params 1
// Size: 0x37
function ref_13346( var0 )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    var1 = getdvarint( "scr_br_display_gulag_close_message", 90 );
    var2 = var0 - var1;
    
    if ( 0 < var2 )
    {
        wait var2;
        setomnvar( "ui_gulag_show_closing_state", 1 );
        return;
    }
}

// Params 0
// Size: 0x63
function run_hud_logic()
{
    var0 = 0;
    
    if ( isdefined( level.br_level ) && isdefined( level.br_level.default_class_chosen ) )
    {
        var1 = remove_engineer_class();
        
        for ( var2 = 0; var2 < var1 ; var2++ )
        {
            var3 = level.br_level.br_circledelaytimes[ var2 ];
            var4 = level.br_level.br_circleclosetimes[ var2 ];
            var0 = var0 + var3 + var4;
        }
    }
    
    return int( var0 );
}

// Params 0
// Size: 0x2e
function playergulagdonesplash()
{
    if ( istrue( self.gulagdone ) )
    {
        return;
    }
    
    self.gulagdone = 1;
    scripts\mp\gametypes\br_killstreaks::isbrsquadleader( self, "gulag_closed", undefined, 2 );
    scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "gulag_gulag_close", self );
}

// Params 1
// Size: 0x18a
function dojailbreak( var0 )
{
    if ( var0.jailedplayers.size == 0 )
    {
        var0.shutdown = 1;
        return;
    }
    
    var0.isjailbreak = 1;
    var0.arenaplayers = scripts\engine\utility::array_removeundefined( var0.jailedplayers );
    jailbreaktimerwait( var0 );
    var1 = getloadoutindex();
    
    foreach ( var3 in var0.arenaplayers )
    {
        thread set_respawn_points( var3 );
        initplayerarena( var3, var0, 1, var1 );
        
        if ( istrue( level.gulag.gestures_enabled ) && !isbot( var3 ) )
        {
            playergulaggesturesdisable( var3 );
        }
        
        if ( getdvarint( "scr_br_fc_outline_countdown", 1 ) > 0 && var0.arenaplayers.size > 0 )
        {
            var3 hudoutlinedisableforclients( var0.arenaplayers );
        }
    }
    
    playsoundatpos( var0.center, "iw8_mp_snatch_fight_start" );
    var0.fightover = 0;
    
    if ( !isoneteamleft( var0 ) )
    {
        var0.time = level.gulag.timelimit;
        updatematchtimerhud( var0, var0.time );
        waittillgulagmatchend( var0, 0 );
    }
    else
    {
        var0.time = 8;
        updatematchtimerhud( var0, var0.time );
        wait var0.time;
    }
    
    foreach ( var3 in var0.arenaplayers )
    {
        if ( isdefined( var3 ) && isdefined( var3.gulagjailbreakhud ) )
        {
            var3.gulagjailbreakhud destroy();
        }
    }
    
    handleendarena( var0 );
    var0.shutdown = 1;
}

// Params 1
// Size: 0x10c
function jailbreaktimerwait( var0 )
{
    foreach ( var2 in var0.arenaplayers )
    {
        if ( !isdefined( var2 ) )
        {
            continue;
        }
        
        var2 thread scripts\mp\hud_message::showsplash( "br_gulag_jail_break" );
        
        if ( getdvarint( "scr_br_fc_outline_countdown", 1 ) > 0 )
        {
            var2 hudoutlineenableforclients( var0.arenaplayers, "outline_nodepth_red" );
        }
    }
    
    wait 3;
    
    foreach ( var2 in var0.arenaplayers )
    {
        if ( !isdefined( var2 ) )
        {
            continue;
        }
        
        playeraddjailbreaktimer( var2 );
    }
    
    gulagcountdowntimer( var0, 0 );
    
    foreach ( var2 in var0.arenaplayers )
    {
        if ( !isdefined( var2 ) )
        {
            continue;
        }
        
        var2 setclientomnvar( "ui_match_start_countdown", 0 );
        var2 setclientomnvar( "ui_match_in_progress", 1 );
        
        if ( isdefined( var2 ) && isdefined( var2.gulagjailbreakhud ) )
        {
            var2.gulagjailbreakhud.label = &"MP/BR_GULAG_JAILBREAK";
        }
    }
}

// Params 0
// Size: 0x3c
function playeraddjailbreaktimer()
{
    self.gulagjailbreakhud = scripts\mp\hud_util::createfontstring( "default", 2 );
    self.gulagjailbreakhud scripts\mp\hud_util::setpoint( "CENTER", "CENTER", 0, -150 );
    self.gulagjailbreakhud.label = &"MP/BR_GULAG_JAILBREAK_IN";
}

// Params 1
// Size: 0x48
function resetequipment( var0 )
{
    if ( !istrue( level.gulag.ref_13672 ) )
    {
        return;
    }
    
    for ( var1 = 0; var1 < var0.weapons.size ; var1++ )
    {
        var2 = var0.weapons[ var1 ];
        var2 setscriptablepartstate( var2.part, "visible" );
    }
}

// Params 1
// Size: 0x10, Type: bool
function validateplayers( var0 )
{
    return var0.arenaplayers.size >= 2;
}

// Params 1
// Size: 0x2de
function beginnewfight( var0 )
{
    level endon( "game_ended" );
    var0 endon( "fight_over_early" );
    level notify( "gulag_begin_new_fight", var0 );
    var0.fightover = 0;
    resetequipment( var0 );
    ref_12c6b( var0 );
    var0.arenaplayers = popnextmatch( var0 );
    var1 = 0;
    
    foreach ( var3 in var0.arenaplayers )
    {
        if ( isdefined( var3 ) )
        {
            var0.jailedplayers = scripts\engine\utility::array_remove( var0.jailedplayers, var3 );
        }
        
        if ( !isdefined( var3 ) )
        {
            var1 = 1;
            continue;
        }
        
        if ( var3.gulag == 0 || var3.jailed == 0 || var3.gulagarena == 1 )
        {
            scripts\mp\utility\script::laststand_dogtags( "Player: " + var3.name + " - invalid for gulag - p.gulag = " + var3.gulag + ", p.jailed = " + var3.jailed + ", p.gulagArena = " + var3.gulagarena );
            var1 = 1;
            continue;
        }
        
        var3.fighterindex = var4;
    }
    
    foreach ( var6 in var0.jailedplayers )
    {
        if ( !isdefined( var6 ) )
        {
            continue;
        }
        
        var6.gulagposition--;
        var6 setweaponammoclip( "rock_mp", 5 );
    }
    
    if ( var1 )
    {
        var0.jailedplayers = scripts\engine\utility::array_removeundefined( var0.jailedplayers );
        var0.arenaplayers = scripts\engine\utility::array_removeundefined( var0.arenaplayers );
        
        if ( !validateplayers( var0 ) )
        {
            handleendarena( var0, undefined, 1 );
            return;
        }
    }
    
    var8 = startbetting( var0, var0.arenaplayers );
    
    if ( getdvarint( "scr_br_fc_spectate_outlines", 0 ) )
    {
        thread manageoutlines( var0, var0.arenaplayers, var8 );
    }
    
    var0.arenaspawncounter = 0;
    var9 = getloadoutindex();
    
    foreach ( var6 in var0.arenaplayers )
    {
        if ( !isdefined( var6 ) )
        {
            continue;
        }
        
        thread set_respawn_points( var6, var0 );
        thread initplayerarena( var6, var0, 0 );
    }
    
    thread watchlethaldelay( var0 );
    wait 2;
    
    if ( !validateplayers( var0 ) )
    {
        handleendarena( var0, var8, 1 );
        return;
    }
    
    ref_13fc1( var0 );
    ref_13fc0( var0 );
    var12 = gulagcountdowntimer( var0, 1, var8 );
    
    if ( !var12 )
    {
        return;
    }
    
    endbetting( var0, var8 );
    
    foreach ( var6 in var0.arenaplayers )
    {
        playergulagarenaready( var6 );
        thread ref_12692();
    }
    
    thread ref_13849( var0 );
    var0.time = level.gulag.timelimit;
    updatematchtimerhud( var0, var0.time );
    waittillgulagmatchend( var0, 1 );
    handleendarena( var0, var8 );
    
    if ( !isfightready( var0 ) )
    {
        ref_14009( var0 );
        return;
    }
}

// Params 1
// Size: 0x82
function watchlethaldelay( var0 )
{
    var0 endon( "fight_over" );
    var0 endon( "matchEnded" );
    level endon( "game_ended" );
    
    if ( level.gulag.lethaldelay <= 0 )
    {
        return;
    }
    
    var0.lethaldelaystarttime = gettime();
    var0.lethaldelayendtime = var0.lethaldelaystarttime + level.gulag.lethaldelay * 1000 + level.gulag.impairedkill * 1000 + 2000;
    
    while ( gettime() < var0.lethaldelayendtime )
    {
        waitframe();
    }
    
    var0 notify( "lethal_delay_end" );
}

// Params 1
// Size: 0xc5
function watchlethaldelayplayer( var0 )
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    if ( level.gulag.lethaldelay == 0 )
    {
        return;
    }
    
    if ( !isai( self ) )
    {
        self notifyonplayercommand( "lethal_attempt_gulag", "+frag" );
        self notifyonplayercommand( "lethal_attempt_gulag", "+smoke" );
    }
    
    scripts\mp\equipment::allow_equipment_slot( "primary", 0 );
    scripts\mp\equipment::allow_equipment_slot( "secondary", 0 );
    watchlethaldelayfeedbackplayer( var0, self );
    scripts\mp\equipment::allow_equipment_slot( "primary", 1 );
    scripts\mp\equipment::allow_equipment_slot( "secondary", 1 );
    
    if ( scripts\cp_mp\utility\game_utility::isrealismenabled() )
    {
        self playlocalsound( "ui_restock_lethals" );
    }
    
    self setclientomnvar( "ui_recharge_notify", 2 );
    
    if ( !isai( self ) )
    {
        self notifyonplayercommandremove( "lethal_attempt_gulag", "+frag" );
        self notifyonplayercommandremove( "lethal_attempt_gulag", "+smoke" );
        return;
    }
}

// Params 2
// Size: 0x50
function watchlethaldelayfeedbackplayer( var0, var1 )
{
    level endon( "game_ended" );
    var0 endon( "matchEnded" );
    var0 endon( "lethal_delay_end" );
    
    for ( ;; )
    {
        self waittill( "lethal_attempt_gulag" );
        var2 = ( var0.lethaldelayendtime - gettime() ) / 1000;
        var2 = int( max( 0, ceil( var2 ) ) );
        var1 scripts\mp\hud_message::showerrormessage( "MP/LETHALS_UNAVAILABLE_FOR_N", var2 );
    }
}

// Params 1
// Size: 0xa7
function ref_13849( var0 )
{
    var0 endon( "matchEnded" );
    playsoundatpos( var0.center, "iw8_mp_snatch_fight_start" );
    wait 1;
    scripts\mp\gametypes\br_public::brleaderdialog( "gulag_gulag_active", 0, var0.jailedplayers );
    scripts\mp\gametypes\br_public::brleaderdialog( "gulag_objective", 0, var0.arenaplayers );
    wait 2;
    
    foreach ( var2 in var0.jailedplayers )
    {
        if ( var2.gulagposition <= 1 )
        {
            scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "gulag_next", var2, 0 );
            continue;
        }
        
        if ( var2.gulagposition == 2 )
        {
            scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "gulag_taunt", var2, 0 );
        }
    }
}

// Params 0
// Size: 0x23
function ref_12692()
{
    self endon( "disconnect" );
    self setclientomnvar( "ui_objective_text", 0 );
    wait 3;
    self setclientomnvar( "ui_objective_text", -1 );
}

// Params 4
// Size: 0x53
function handleonekillwin( var0, var1, var2, var3 )
{
    if ( isdefined( var2 ) && isplayer( var2 ) && var1 != var2 && isalive( var2 ) && scripts\engine\utility::array_contains( var0.arenaplayers, var2 ) )
    {
        thread gulagvictory( var0, var2, 0, 0, "winner" );
        payoutbet( var3, var2, 1 );
    }
    
    payoutbet( var3, var1, 0 );
}

// Params 3
// Size: 0x27
function manageoutlines( var0, var1, var2 )
{
    manageoutlineactive( var0, var1, var2 );
    
    if ( istrue( level.gulag.onekillwin ) )
    {
        return;
    }
    
    manageoutlinecleanup( var0, var1 );
}

// Params 1
// Size: 0x1d
function manageoutlineswatchplayersaddedtojail( var0 )
{
    var0 endon( "fight_over" );
    
    for ( ;; )
    {
        var0 waittill( "player_added_to_jail" );
        updateoutlines( var0 );
    }
}

// Params 3
// Size: 0xf6
function manageoutlineactive( var0, var1, var2 )
{
    var0 endon( "fight_over" );
    thread manageoutlineswatchplayersaddedtojail( var0 );
    
    for ( ;; )
    {
        if ( var0.jailedplayers.size )
        {
            var3 = scripts\engine\utility::array_removeundefined( var0.jailedplayers );
            
            foreach ( var5 in var1 )
            {
                if ( !isdefined( var5 ) )
                {
                    continue;
                }
                
                var5 hudoutlineenableforclients( var3, "outline_nodepth_white" );
            }
        }
        
        if ( isdefined( var2 ) )
        {
            foreach ( var8 in var2.bets )
            {
                if ( !isdefined( var8.owner ) )
                {
                    continue;
                }
                
                var9 = scripts\engine\utility::ter_op( var2.bettingopen, var8.playerfocus, var8.playerbeton );
                
                if ( var9 != -1 )
                {
                    var10 = var2.fighters[ var9 ];
                    
                    if ( isdefined( var10 ) )
                    {
                        var10 hudoutlineenableforclient( var8.owner, "outline_nodepth_green" );
                    }
                }
            }
        }
        
        var0 waittill( "update_outlines" );
    }
}

// Params 2
// Size: 0x4a
function manageoutlinecleanup( var0, var1 )
{
    var2 = scripts\engine\utility::array_removeundefined( var0.jailedplayers );
    
    if ( !var2.size )
    {
        return;
    }
    
    foreach ( var4 in var1 )
    {
        if ( !isdefined( var4 ) )
        {
            continue;
        }
        
        var4 hudoutlinedisableforclients( var2 );
    }
}

// Params 1
// Size: 0xc
function updateoutlines( var0 )
{
    var0 notify( "update_outlines" );
}

// Params 0
// Size: 0x4a
function playergulagarenaready()
{
    ref_126b0( 1 );
    self setclientomnvar( "ui_br_infil_started", 1 );
    self setclientomnvar( "ui_match_start_countdown", 0 );
    self setclientomnvar( "ui_match_in_progress", 1 );
    
    if ( istrue( level.gulag.gestures_enabled ) && !isbot( self ) )
    {
        playergulaggesturesdisable();
        return;
    }
}

// Params 3
// Size: 0x85, Type: bool
function gulagcountdowntimer( var0, var1, var2 )
{
    var3 = level.gulag.impairedkill;
    
    while ( var3 > 0 )
    {
        foreach ( var5 in var0.arenaplayers )
        {
            var5 setclientomnvar( "ui_match_in_progress", 0 );
            var5 setclientomnvar( "ui_match_start_countdown", var3 );
        }
        
        var3 -= 1;
        wait 1;
        
        if ( istrue( var1 ) && !validateplayers( var0 ) )
        {
            handleendarena( var0, var2, 1 );
            return false;
        }
    }
    
    return true;
}

// Params 3
// Size: 0x5b
function set_relic_vampire( var0, var1, var2 )
{
    var0 endon( "matchEnded" );
    
    while ( var1 > 0 )
    {
        if ( level.gameended )
        {
            return;
        }
        
        var3 = var1;
        
        if ( !istrue( var0.overtime ) )
        {
            var3 -= var2;
        }
        
        if ( var3 <= 5 )
        {
            var4 = scripts\mp\gamelogic::relic_bang_and_boom_dropfunc( var3 );
            lower_target_when_close( var0, var4 );
        }
        
        if ( var1 > 1 )
        {
            var1 -= 1;
        }
        
        wait 1;
    }
}

// Params 2
// Size: 0x67
function lower_target_when_close( var0, var1 )
{
    foreach ( var3 in var0.jailedplayers )
    {
        if ( isdefined( var3 ) )
        {
            var3 playlocalsound( var1 );
        }
    }
    
    foreach ( var3 in var0.arenaplayers )
    {
        if ( isdefined( var3 ) )
        {
            var3 playlocalsound( var1 );
        }
    }
}

// Params 0
// Size: 0x10
function respawn_scriptible_carriable_wait()
{
    return getdvarint( "scr_br_fc_overtime", 15 );
}

// Params 2
// Size: 0x17f
function waittillgulagmatchend( var0, var1 )
{
    var2 = respawn_scriptible_carriable_wait();
    var0.time += var2;
    thread set_relic_vampire( var0, var0.time, var2 );
    
    for ( ;; )
    {
        if ( !isanyonealive( var0 ) || isoneteamleft( var0 ) )
        {
            break;
        }
        
        var0.time -= level.framedurationseconds;
        
        if ( istrue( level.gulag.arenaflag ) && !istrue( var0.overtime ) && var0.time <= var2 )
        {
            var0.overtime = 1;
            calloutmarkerping_watchwhenobjectivedeleted( var0.managevehiclehealthui.arenaflag, 1 );
            calloutmarkerping_watchwhenobjectivestartsprogress( var0.managevehiclehealthui.arenaflag, var0, 1 );
            var0.managevehiclehealthui.arenaflag.flagmodel playsoundonmovingent( "flag_spawned" );
        }
        
        if ( istrue( var0.overtime ) )
        {
            var3 = clamp( var0.time / var2, 0, 1 );
            ref_13194( var0, var3 );
        }
        
        if ( var0.time <= 0 )
        {
            ref_143ef( var0 );
            
            if ( istrue( var1 ) )
            {
                foreach ( var5 in var0.arenaplayers )
                {
                    thread set_respawn_loc_delayed( var5 );
                    var6 = scripts\mp\music_and_dialog::reset_attack_next_available_time( "br_gulag_lose" );
                    var5 setplayermusicstate( var6 );
                    var5 playsoundtoplayer( "gulag_crowd_boo_loser", var5 );
                    var5 clearclienttriggeraudiozone( 2 );
                }
            }
            
            break;
        }
        
        waitframe();
    }
    
    var0 notify( "matchEnded" );
}

// Params 1
// Size: 0x53
function ref_143ef( var0 )
{
    while ( isdefined( var0.managevehiclehealthui.arenaflag.claimteam ) && var0.managevehiclehealthui.arenaflag.claimteam != "none" && !istrue( var0.managevehiclehealthui.arenaflag.stalemate ) )
    {
        waitframe();
    }
}

// Params 1
// Size: 0x37, Type: bool
function isanyonealive( var0 )
{
    foreach ( var2 in var0.arenaplayers )
    {
        if ( isalive( var2 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Params 1
// Size: 0x43, Type: bool
function issquadwiped( var0 )
{
    foreach ( var2 in level.teamdata[ var0 ][ "players" ] )
    {
        if ( isdefined( var2 ) && isalive( var2 ) )
        {
            return false;
        }
    }
    
    return true;
}

// Params 1
// Size: 0x59, Type: bool
function isoneteamleft( var0 )
{
    var1 = undefined;
    
    foreach ( var3 in var0.arenaplayers )
    {
        if ( isalive( var3 ) )
        {
            if ( !isdefined( var1 ) )
            {
                var1 = var3.team;
                continue;
            }
            
            if ( var1 != var3.team )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Params 6
// Size: 0x14c
function handleendarena( var0, var1, var2, var3, var4, var5 )
{
    var0 notify( "lethal_delay_end" );
    var0 notify( "fight_over" );
    var0.fightover = 1;
    
    if ( !isdefined( var4 ) )
    {
        var4 = "winner";
    }
    
    endbetting( var0, var1 );
    updatematchtimerhud( var0, 0 );
    var6 = undefined;
    
    foreach ( var8 in var0.arenaplayers )
    {
        if ( !isdefined( var8 ) )
        {
            continue;
        }
        
        if ( isalive( var8 ) )
        {
            var6 = var8;
            
            if ( istrue( var2 ) )
            {
                playergulagarenaready( var6 );
            }
            
            if ( isdefined( var5 ) && var8.team == var5.team )
            {
                thread gulagvictory( var0, var8, 0, 0, var4, 0, var5, var3 );
                continue;
            }
            
            thread gulagvictory( var0, var8, 0, 0, "winner" );
        }
    }
    
    if ( istrue( level.gulag.arenaflag ) && istrue( var0.overtime ) )
    {
        calloutmarkerping_watchwhenobjectivedeleted( var0.managevehiclehealthui.arenaflag, 0 );
    }
    
    payoutremainingbets( var6, var1 );
    wait 2;
    
    if ( istrue( level.gulag.arenaflag ) && istrue( var0.overtime ) )
    {
        var0.overtime = 0;
        calloutmarkerping_watchwhenobjectivestartsprogress( var0.managevehiclehealthui.arenaflag, var0, 0 );
    }
    
    handlesoloexclusionils( var0 );
    wait 1;
}

// Params 2
// Size: 0xf4
function ref_12642( var0, var1 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "gulag_end" );
    
    if ( !isdefined( self.arena ) )
    {
        return;
    }
    
    var2 = self.arena;
    
    if ( istrue( self.ref_14439 ) )
    {
        self notify( "pull_out_of_gulag" );
        
        if ( !isalive( self ) )
        {
            thread playergulagautowin( "playerPullOutOfGulagWin1", var0 );
            return;
        }
        else if ( istrue( self.delay_enter_combat_after_investigating_grenade ) )
        {
            scripts\mp\gametypes\br::ref_13f21( self, "playerPullOutOfGulagWin2" );
            level thread scripts\mp\gametypes\br::ref_14006();
        }
    }
    else if ( istrue( self.gulagarena ) )
    {
        if ( !var2.fightover )
        {
            var2 notify( "matchEnded" );
            var2 notify( "fight_over_early" );
            thread handleendarena( var2, undefined, 1, 1, var1, var0 );
        }
        
        return;
    }
    else
    {
        var2.jailedplayers = scripts\engine\utility::array_remove( var2.jailedplayers, self );
        updatematchqueuepositions( var2 );
        
        if ( istrue( self.gulag ) && !istrue( self.jailed ) )
        {
            self waittill( "gulag_start" );
        }
    }
    
    thread gulagvictory( var2, self, 1, 0, var1, 0, var0, 1 );
}

// Params 1
// Size: 0x51
function getnextjailspawn( var0 )
{
    if ( isdefined( var0.jailspawncounter ) )
    {
        var0.jailspawncounter++;
        var0.jailspawncounter %= var0.jailspawns.size;
    }
    else
    {
        var0.jailspawncounter = 0;
    }
    
    var1 = var0.jailspawns[ var0.jailspawncounter ];
    return var1;
}

// Params 2
// Size: 0x33
function ref_13255( var0, var1 )
{
    if ( isdefined( var1.target ) )
    {
        var2 = scripts\engine\utility::getstruct( var1.target, "targetname" );
        
        if ( isdefined( var2 ) )
        {
            var1.chair = var2;
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x15b
function outlinewatchplayerprox( var0 )
{
    self endon( "death" );
    self endon( "trigger" );
    self.outlinedplayers = [];
    
    switch ( var0 )
    {
        case 0:
        default:
            var1 = "outline_depth_white";
            break;
        case 1:
            var1 = "outline_depth_green";
            break;
        case 2:
            var1 = "outline_depth_cyan";
            break;
        case 3:
            var1 = "outline_depth_red";
            break;
        case 4:
            var1 = "outline_depth_orange";
            break;
    }
    
    for ( ;; )
    {
        var2 = scripts\common\utility::playersinsphere( self.origin, 2000 );
        var3 = scripts\engine\utility::array_difference( level.players, var2 );
        
        foreach ( var5 in var2 )
        {
            var6 = distancesquared( self.origin, var5.origin );
            var7 = var5 getentitynumber();
            
            if ( !isdefined( self.outlinedplayers[ var7 ] ) )
            {
                self.outlinedplayers[ var7 ] = scripts\mp\utility\outline::outlineenableforplayer( self, var5, var1, "level_script" );
            }
        }
        
        foreach ( var5 in var3 )
        {
            var7 = var5 getentitynumber();
            
            if ( isdefined( self.outlinedplayers[ var7 ] ) )
            {
                scripts\mp\utility\outline::outlinedisable( self.outlinedplayers[ var7 ], self );
                self.outlinedplayers[ var7 ] = undefined;
            }
        }
        
        waitframe();
    }
}

// Params 1
// Size: 0x36, Type: bool
function gulagstreamlocationstart( var0 )
{
    if ( ( isbot( self ) || self calloutmarkerping_getent() ) && !istrue( self.ref_119d7 ) )
    {
        return false;
    }
    
    self calloutmarkerping_getcreatedtime( 10000 );
    self setadditionalstreampos( var0, 1 );
    return !self isadditionalstreamposready();
}

// Params 0
// Size: 0x44
function gulagstreamlocationwait()
{
    if ( !istrue( self.ref_119d7 ) )
    {
        self endon( "gulagStreamLocationComplete" );
        thread gulagstreamlocationwaittimeout( level.gulag.ref_1391b );
        
        while ( !self isadditionalstreamposready() )
        {
            waitframe();
        }
        
        self notify( "gulagStreamLocationComplete" );
        return;
    }
    
    wait level.gulag.ref_1391b;
}

// Params 1
// Size: 0x1c
function gulagstreamlocationwaittimeout( var0 )
{
    self endon( "disconnect" );
    self endon( "gulagStreamLocationComplete" );
    wait var0;
    self notify( "gulagStreamLocationComplete" );
}

// Params 0
// Size: 0xf
function gulagstreamlocationend()
{
    self clearadditionalstreampos();
    self notify( "gulagStreamLocationComplete" );
}

// Params 0
// Size: 0xc
function set_scriptable_states()
{
    self calloutmarkerping_getcreatedtime( 0 );
}

// Params 2
// Size: 0x29
function addloadingplayer( var0, var1 )
{
    var1.entergulagwait = 1;
    var0.loadingplayers[ var0.loadingplayers.size ] = var1;
    thread addloadingplayerdisconnectwatch( var0, var1 );
}

// Params 2
// Size: 0x1c
function addloadingplayerdisconnectwatch( var0, var1 )
{
    var1 endon( "removeLoadingPlayer" );
    var1 waittill( "disconnect" );
    thread removeloadingplayer( var0, var1 );
}

// Params 2
// Size: 0x56
function removeloadingplayer( var0, var1 )
{
    var1 notify( "removeLoadingPlayer" );
    
    if ( isdefined( var1 ) )
    {
        var0.loadingplayers = scripts\engine\utility::array_remove( var0.loadingplayers, var1 );
    }
    else
    {
        var0.loadingplayers = scripts\engine\utility::array_removeundefined( var0.loadingplayers );
    }
    
    if ( var0.loadingplayers.size == 0 )
    {
        var0 notify( "loadingPlayersEmpty" );
        return;
    }
}

// Params 2
// Size: 0x13
function updatelootleadercirclesize( var0, var1 )
{
    return scripts\engine\utility::array_contains( var1.loadingplayers, var0 );
}

// Params 1
// Size: 0x1c
function entergulag( var0 )
{
    var0 notify( "enter_gulag" );
    var0.entergulagwait = 0;
    scripts\mp\deathicons::spawn_carriables_from_prefabs_all( var0 );
}

// Params 1
// Size: 0x17
function entergulagwait( var0 )
{
    if ( var0.entergulagwait )
    {
        var0 waittill( "enter_gulag" );
        return;
    }
}

// Params 0
// Size: 0x229
function playergetnextarena()
{
    if ( !istrue( level.gulag.multiarena ) )
    {
        return level.gulag.arenas[ 0 ];
    }
    
    var1 = undefined;
    var2 = undefined;
    
    foreach ( var8, var4 in level.gulag.arenas )
    {
        foreach ( var6 in var4.matches )
        {
            if ( var6.size == 1 && isdefined( var6[ 0 ] ) && var6[ 0 ].team != self.team && ( !isdefined( var1 ) || var6[ 0 ].vehicle_compass_friendlystatuschangedcallback < var2 ) )
            {
                var1 = var4;
                var2 = var6[ 0 ].vehicle_compass_friendlystatuschangedcallback;
            }
        }
    }
    
    if ( isdefined( var1 ) )
    {
        return var1;
    }
    
    var9 = [];
    
    for ( var10 = 0; var10 < level.gulag.arenas.size ; var10++ )
    {
        var4 = level.gulag.arenas[ var10 ];
        
        if ( var4.matches.size > 0 && var4.matches.size < level.gulag.maxqueue )
        {
            var9 = var4;
        }
    }
    
    if ( var9.size > 0 )
    {
        foreach ( var17, var4 in var9 )
        {
            foreach ( var6 in var4.matches )
            {
                foreach ( var14 in var6 )
                {
                    if ( isdefined( var14 ) && var14.team == self.team )
                    {
                        return var4;
                    }
                }
            }
        }
        
        var4 = var9[ randomint( var9.size ) ];
        return var4;
    }
    
    var8 = undefined;
    var18 = undefined;
    
    for ( var17 = 0; var17 < level.gulag.arenas.size ; var17++ )
    {
        var11 = level.gulag.arenas[ var17 ];
        
        if ( var11.matches.size == 0 )
        {
            return var11;
        }
        
        if ( !isdefined( var18 ) || var11.matches.size < var18 )
        {
            var8 = var11;
            var18 = var11.matches.size;
        }
    }
    
    return var8;
}

// Params 2
// Size: 0x37, Type: bool
function updatelootleadermarks( var0, var1 )
{
    if ( !ismatchpending( var0 ) )
    {
        return false;
    }
    
    var2 = var1.gulagposition - 1;
    
    if ( var2 >= 0 && var0.matches[ var2 ].size > 1 )
    {
        return true;
    }
    
    return false;
}

// Params 1
// Size: 0x68
function ref_13165( var0 )
{
    foreach ( var2 in var0.jailedplayers )
    {
        if ( !updatelootleadermarks( var0, var2 ) && isdefined( var2.vehicle_compass_getleveldata ) && !isdefined( var2.vehicle_compass_hide ) )
        {
            var2 setclientomnvar( "ui_br_gulag_match_end_time", var2.vehicle_compass_getleveldata );
            var2.vehicle_compass_hide = 1;
        }
    }
}

// Params 1
// Size: 0x1b
function ref_12527( var0 )
{
    self.vehicle_compass_getleveldata = undefined;
    self.vehicle_compass_hide = undefined;
    self setclientomnvar( "ui_br_gulag_match_end_time", 0 );
}

// Params 1
// Size: 0xc2
function ref_125f4( var0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "initPlayerArena" );
    self endon( "gulag_end" );
    var1 = getdvarint( "scr_br_fc_jailTimeout", 95 );
    
    if ( var1 <= 0 )
    {
        return;
    }
    
    self.vehicle_compass_getleveldata = gettime() + var1 * 1000;
    wait var1;
    
    if ( updatelootleadermarks( var0, self ) )
    {
        var2 = self.gulagposition * ( level.gulag.timelimit + respawn_scriptible_carriable_wait() + level.gulag.impairedkill + 2 + 2 + 1 + 1 );
        var3 = gettime() + var2 * 1000;
        
        while ( var3 > gettime() && updatelootleadermarks( var0, self ) )
        {
            waitframe();
        }
    }
    
    while ( unset_relic_martyrdom() )
    {
        waitframe();
    }
    
    thread gulagvictory( var0, self, 1, 0, "timeout" );
}

// Params 0
// Size: 0x26
function updatecanusegulag()
{
    var0 = self;
    
    if ( !isdefined( var0.gulaguses ) )
    {
        self.gulaguses = 0;
    }
    
    var1 = ref_12517( var0 );
    var0 scripts\mp\gametypes\br_public::setcanusegulagextrainfo( var1 );
}

// Params 1
// Size: 0x42c
function initplayerjail( var0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "gulag_end" );
    self.vehicle_compass_friendlystatuschangedcallback = gettime();
    self.gulagloser = 0;
    self.nosuspensemusic = 1;
    scripts\mp\gametypes\br_analytics::destroyawardlaunchonly( self, scripts\engine\utility::ter_op( istrue( var0 ), "default", "debug" ) );
    ref_1263c();
    var1 = playergetnextarena();
    self.arena = var1;
    
    if ( !scripts\engine\utility::array_contains( var1.jailedplayers, self ) )
    {
        var1 notify( "player_added_to_jail", self );
        var1.jailedplayers[ var1.jailedplayers.size ] = self;
    }
    
    playergulaghud( var1 );
    thread playerwatchdisconnect( var1 );
    updatematchqueuepositions( var1 );
    addloadingplayer( var1, self );
    set_relic_steelballs( self );
    
    if ( !isdefined( self.gulaguses ) )
    {
        self.gulaguses = 0;
    }
    
    self.gulaguses++;
    updatecanusegulag();
    setplayervargulag( 1 );
    setplayervargulagarena( 0 );
    ref_131a2( 1 );
    ref_1319f( var1 );
    scripts\mp\outofbounds::enableoobimmunity( self );
    
    if ( isdefined( level.getinfilplayers ) )
    {
        [[ level.getinfilplayers ]]();
    }
    
    var2 = getnextjailspawn( var1 );
    var3 = getgroundposition( var2.origin, 12 );
    var4 = ( 0, 0, 0 );
    
    if ( isdefined( var2.angles ) )
    {
        var4 = var2.angles;
    }
    
    var5 = gulagstreamlocationstart( var3 );
    self.set_relic_steelballs_perks = 1;
    self.ref_1391a = spawnstruct();
    self.ref_1391a.origin = var3;
    self.ref_1391a.angles = var4;
    
    if ( istrue( var0 ) )
    {
        entergulagwait( self );
    }
    else
    {
        entergulag( self );
    }
    
    scripts\mp\gametypes\br_quest_util::ref_1206c();
    scripts\mp\gametypes\br_alt_mode_escape::obj_hangar_bombs();
    _calloutmarkerping_isvehicleoccupiedbyenemy::loadout_finalizeweapons( "gulag" );
    var6 = gettime();
    
    if ( scripts\mp\gametypes\br_public::tutorial_playsound() )
    {
        self notify( "play_gulag_vo" );
    }
    
    if ( level.gulag.betting )
    {
        var7 = level.gulag.juggheli_spawner_jammer5_2;
        
        if ( isdefined( self.plundercountondeath ) )
        {
            var7 = int( max( var7, int( self.plundercountondeath / 2 ) ) );
        }
        
        scripts\mp\gametypes\br_plunder::playersetplundercount( var7 );
    }
    
    ref_12617();
    
    if ( var5 )
    {
        scripts\mp\gametypes\br::spawnintermission( var3 + ( 0, 0, 100 ), self.angles );
        scripts\mp\spectating::setdisabled();
        gulagstreamlocationstart( var3 );
    }
    
    if ( var5 )
    {
        gulagstreamlocationwait();
    }
    
    if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "playerPreSpawnGulagJail" ) )
    {
        scripts\mp\gametypes\br_gametypes::ref_12e05( "playerPreSpawnGulagJail" );
    }
    
    scripts\mp\class::loadout_emptycacheofloadout( "gamemode" );
    self.pers[ "gamemodeLoadout" ] = level.gulag.vehicle_compass_deregisterinstance;
    self.class = "gamemode";
    self.forcespawnangles = var4;
    self.forcespawnorigin = var3;
    scripts\mp\playerlogic::spawnplayer( undefined, 0 );
    scripts\cp_mp\execution::_clearexecution();
    self setclientomnvar( "ui_gulag", 1 );
    self.ref_1391a = undefined;
    self.set_relic_steelballs_perks = 0;
    ref_12c7a();
    
    if ( var5 )
    {
        gulagstreamlocationend();
    }
    
    ref_12694();
    ref_126ea( var6 );
    
    if ( scripts\mp\gametypes\br_public::tutorial_playsound() )
    {
        self clearsoundsubmix( "iw8_br_gulag_tutorial", 2 );
    }
    else
    {
        self clearsoundsubmix( "fade_to_black_all_except_music_and_scripted5", 2 );
    }
    
    self setclientomnvar( "ui_br_infil_started", 1 );
    var8 = var1.fightover && ref_125ee( var1 );
    var9 = undefined;
    
    if ( level.gulag.getaccessorylogicbyindex )
    {
        var9 = 0.5;
    }
    
    if ( !var8 )
    {
        gulagfadefromblack( var9 );
    }
    
    gulagloadingtextclear();
    
    if ( !var8 )
    {
        scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "gulag_spawn", self, 0 );
        thread ref_1251a( var1, var2 );
    }
    
    var10 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( self.team, self.squadindex );
    
    foreach ( var12 in var10 )
    {
        if ( !isdefined( var12 ) || !isalive( var12 ) )
        {
            continue;
        }
        
        if ( var12 != self )
        {
            var12 thread scripts\mp\hud_message::showsplash( "br_gulag_teammate_in", undefined, self );
            scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "gulag_teammate_gulag", var12 );
        }
    }
    
    if ( !istrue( self.jailed ) )
    {
        ref_131aa( 1 );
        scripts\mp\utility\perk::blockperkfunction( "specialty_scavenger" );
    }
    
    removeloadingplayer( var1, self );
    scripts\mp\gametypes\br_pickups::initplayer( 1 );
    
    if ( istrue( level.gulag.gestures_enabled ) && !isbot( self ) )
    {
        thread playergulaggestures();
    }
    
    ref_126b3( 0 );
    
    if ( istrue( level.gulag.arenaflag ) && istrue( var1.overtime ) )
    {
        thread calloutmarkerpingvo_canplaywithspamavoidance( var1.managevehiclehealthui.arenaflag, 1 );
    }
    
    thread ref_125f4( var1 );
    thread ref_125f5( var1 );
    self notify( "gulag_start" );
}

// Params 1
// Size: 0x3a
function ref_125f5( var0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "initPlayerArena" );
    self endon( "gulag_end" );
    wait 5;
    
    if ( ismatchpending( var0 ) )
    {
        return;
    }
    
    scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "gulag_obj_wait", self, 0 );
}

// Params 1
// Size: 0x14
function ref_126b3( var0 )
{
    if ( var0 )
    {
        self enableoffhandthrowback();
        return;
    }
    
    self disableoffhandthrowback();
}

// Params 0
// Size: 0x155
function playergulaggestures()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "gulag_gestures_stop" );
    self enableoffhandweapons();
    self allowfire( 0 );
    self allowads( 0 );
    self notifyonplayercommand( "fc_gesture_neg", "+attack" );
    self notifyonplayercommand( "fc_gesture_pos", "+speed_throw" );
    var0 = 0;
    
    for ( ;; )
    {
        var1 = scripts\engine\utility::ref_143ad( "fc_gesture_neg", "fc_gesture_pos" );
        
        if ( self isgestureplaying() || self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing() )
        {
            continue;
        }
        
        if ( getdvarint( "scr_br_fc_gestures_test", 0 ) > 0 )
        {
            if ( var0 >= level.gulag.gestures[ var1 ].size )
            {
                var0 = 0;
            }
            
            var2 = level.gulag.gesturesounds[ var1 ][ var0 ];
            var3 = level.gulag.gestures[ var1 ][ var0 ];
            var0++;
        }
        else
        {
            var0 = randomint( level.gulag.gestures[ var1 ].size );
            var2 = level.gulag.gesturesounds[ var1 ][ var0 ];
            var3 = level.gulag.gestures[ var1 ][ var0 ];
        }
        
        if ( isdefined( var2 ) && var2 != "" )
        {
            self playsound( var2 );
        }
        
        var4 = getcompleteweaponname( var3 );
        
        if ( isdefined( var4 ) && !nullweapon( var4 ) )
        {
            scripts\cp_mp\gestures::watchradialgesture( var4 );
        }
    }
}

// Params 0
// Size: 0x36
function playergulaggesturesdisable()
{
    self notify( "gulag_gestures_stop" );
    self notifyonplayercommandremove( "fc_gesture_neg", "+attack" );
    self notifyonplayercommandremove( "fc_gesture_pos", "+speed_throw" );
    self allowfire( 1 );
    self allowads( 1 );
}

// Params 1
// Size: 0x29
function fadeoutin( var0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    
    if ( !isdefined( var0 ) )
    {
        var0 = 1;
    }
    
    gulagfadetoblack();
    wait var0;
    gulagfadefromblack();
}

// Params 1
// Size: 0x14
function gulagfadetoblack( var0 )
{
    ref_12522();
    
    if ( istrue( var0 ) )
    {
        set_relic_noluck();
        return;
    }
}

// Params 1
// Size: 0x10
function gulagfadefromblack( var0 )
{
    thread ref_12523( var0 );
    set_relic_noks();
}

// Params 0
// Size: 0x32
function set_relic_noluck()
{
    var0 = scripts\mp\gametypes\br_spectate::rotatetocurrentangles( self );
    
    foreach ( var2 in var0 )
    {
        ref_12522( var2 );
    }
}

// Params 0
// Size: 0x4a
function set_relic_noks()
{
    var0 = scripts\mp\gametypes\br_spectate::rotatetocurrentangles( self );
    
    foreach ( var2 in var0 )
    {
        if ( getdvarint( "scr_br_bink_overlay_log", 0 ) == 1 )
        {
            logstring( "bnk_gulagFadeFromBlackSpectatorsOfPlayer()" );
        }
        
        thread ref_12523();
    }
}

// Params 1
// Size: 0x29
function patch_self_check( var0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    
    if ( !isdefined( var0 ) )
    {
        var0 = 1;
    }
    
    set_relic_noluck();
    wait var0;
    set_relic_noks();
}

// Params 0
// Size: 0xe, Type: bool
function set_relic_punchbullets()
{
    if ( ref_125eb() )
    {
        return true;
    }
    
    return false;
}

// Params 0
// Size: 0x3a
function gulagloadingtext()
{
    var0 = scripts\mp\hud_util::createfontstring( "default", 1.5 );
    var0 scripts\mp\hud_util::setpoint( "CENTER", "CENTER", 0, -100 );
    var0.label = &"MP/BR_GULAG_TRAVEL";
    self.gulagloadingtext = var0;
}

// Params 0
// Size: 0x15
function gulagloadingtextclear()
{
    if ( isdefined( self.gulagloadingtext ) )
    {
        self.gulagloadingtext destroy();
        return;
    }
}

// Params 2
// Size: 0x18
function ref_126c3( var0, var1 )
{
    self cancelmantle();
    self setorigin( var0, 1 );
    self setplayerangles( var1 );
}

// Params 3
// Size: 0x1f1
function initplayerarena( var0, var1, var2 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self notify( "initPlayerArena" );
    ref_1251f();
    scripts\mp\gametypes\br_pickups::initplayer();
    self allowprone( 0 );
    self allowcrouch( 0 );
    ref_126b3( 1 );
    ref_126b0( 0 );
    playertakeawayrock( var0 );
    ref_12527( var0 );
    scripts\mp\equipment::allow_equipment_slot( "primary", 0 );
    scripts\mp\equipment::allow_equipment_slot( "secondary", 0 );
    thread ref_125cc( var0 );
    
    if ( istrue( var1 ) )
    {
        ref_131aa( 0 );
        setplayervargulagarena( 1 );
        playergivearenaloadout( var0, var2 );
        
        if ( level.gulag.lethaldelay > 0 )
        {
            thread watchlethaldelayplayer( var0 );
        }
        
        return;
    }
    
    scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "gulag_spawn_rules", self, 0 );
    var3 = set_relic_punchbullets();
    
    if ( !var3 )
    {
        thread fadeoutin();
    }
    
    thread patch_self_check();
    wait 1;
    playergivearenaloadout( var0, var2 );
    thread ref_126c8( 3 );
    
    if ( getdvarint( "scr_br_verify_gulag_loadouts", 0 ) == 1 )
    {
        level.gulag.lethaldelay = 0;
        thread ref_1428f( var0 );
    }
    
    if ( level.gulag.lethaldelay > 0 )
    {
        thread watchlethaldelayplayer( var0 );
    }
    
    var4 = getnextarenaspawn( var0 );
    var5 = getgroundposition( var4.origin, 1 );
    var6 = var4.angles;
    
    if ( !isdefined( var4.angles ) )
    {
        var6 = ( 0, 0, 0 );
    }
    
    ref_126c3( var5, var6 );
    ref_131aa( 0 );
    setplayervargulagarena( 1 );
    self.health = self.maxhealth;
    scripts\mp\gametypes\br_armor::scriptablescurid( level.gulag.ref_11f2d );
    
    if ( getdvarint( "scr_br_fc_outline_countdown", 1 ) > 0 )
    {
        self hudoutlineenableforclients( var0.arenaplayers, "outline_nodepth_red" );
    }
    
    if ( var3 )
    {
        gulagfadefromblack();
    }
    
    wait 1;
    self allowprone( 1 );
    self allowcrouch( 1 );
    wait level.gulag.impairedkill - 1;
    wait 1;
    
    if ( getdvarint( "scr_br_fc_outline_countdown", 1 ) > 0 && var0.arenaplayers.size > 0 )
    {
        self hudoutlinedisableforclients( var0.arenaplayers );
        return;
    }
}

// Params 1
// Size: 0x52
function ref_126b0( var0 )
{
    if ( var0 )
    {
        self allowmelee( 1 );
        self allowmovement( 1 );
        self enableusability();
        self enableoffhandweapons();
        self allowads( 1 );
        self allowfire( 1 );
        return;
    }
    
    self allowmelee( 0 );
    self allowmovement( 0 );
    self disableusability();
    self disableoffhandweapons();
    self allowads( 0 );
    self allowfire( 0 );
}

// Params 1
// Size: 0x6c
function getnextarenaspawn( var0 )
{
    if ( !isdefined( var0.arenaspawncounter ) )
    {
        var0.arenaspawncounter = 0;
    }
    
    var1 = undefined;
    
    if ( ref_14069( var0 ) )
    {
        var1 = var0.get_wave_spawn_total[ var0.arenaspawncounter ];
    }
    else
    {
        var1 = var0.fightspawns[ var0.arenaspawncounter ];
    }
    
    var0.arenaspawncounter++;
    var0.arenaspawncounter %= var0.fightspawns.size;
    return var1;
}

// Params 1
// Size: 0x30
function ref_126c8( var0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self.plotarmor = 1;
    scripts\engine\utility::ref_143c0( var0, "death", "gulagRespawn" );
    self.plotarmor = undefined;
}

// Params 8
// Size: 0x2d9
function gulagvictory( var0, var1, var2, var3, var4, var5, var6, var7 )
{
    level endon( "game_ended" );
    var1 endon( "death_or_disconnect" );
    var1 notify( "gulag_end" );
    
    if ( !isdefined( var5 ) )
    {
        var5 = 0;
    }
    
    thread ref_1251f();
    ref_12527( var1 );
    thread ref_126c8( var1 );
    var1.gulagloser = 0;
    
    if ( var0.jailedplayers.size > 0 && getdvarint( "scr_br_fc_spectate_outlines", 0 ) )
    {
        var1 hudoutlinedisableforclients( var0.jailedplayers );
    }
    
    var0.arenaplayers = scripts\engine\utility::array_removeundefined( var0.arenaplayers );
    
    if ( var0.arenaplayers.size > 0 && getdvarint( "scr_br_fc_outline_countdown", 1 ) > 0 )
    {
        var1 hudoutlinedisableforclients( var0.arenaplayers );
    }
    
    var0.arenaplayers = scripts\engine\utility::array_remove( var0.arenaplayers, var1 );
    var8 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( var1.team, var1.squadindex );
    
    foreach ( var10 in var8 )
    {
        if ( var10 != var1 )
        {
            var10 thread scripts\mp\hud_message::showsplash( "br_gulag_teammate_out", undefined, var1 );
            scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "gulag_teammate_win", var10 );
        LOC_00000126:
        }
    LOC_00000126:
    }
    
    var12 = "";
    
    if ( isdefined( var4 ) )
    {
        var12 = var4;
    }
    
    if ( !isdefined( var1.ref_145bf ) )
    {
        ref_126f3( var1, 1 );
    }
    
    if ( !istrue( var3 ) && !istrue( var5 ) && !istrue( var7 ) )
    {
        thread ref_13dcb( var1 );
    }
    
    if ( var2 )
    {
        if ( !istrue( var3 ) )
        {
            if ( var4 == "timeout" )
            {
                scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "gulag_timeout", var1, 0 );
            }
            else
            {
                scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "gulag_noenemy", var1, 0 );
            }
        }
        
        var0.jailedplayers = scripts\engine\utility::array_remove( var0.jailedplayers, var1 );
        updatematchqueuepositions( var0 );
    }
    else
    {
        scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "gulag_win", var1, 0 );
    }
    
    var1 playsoundtoplayer( "gulag_crowd_cheer_winner", var1 );
    var13 = scripts\mp\music_and_dialog::reset_attack_next_available_time( "br_gulag_win" );
    var1 setplayermusicstate( var13 );
    
    if ( istrue( level.gulag.onekillwin ) && ( istrue( var0.isjailbreak ) || level.gulag.maxplayers > 2 ) )
    {
        var1 playerhide();
    }
    
    ref_126b3( var1, 1 );
    ref_126b0( var1, 1 );
    ref_125bf( var1, 0 );
    var1 scripts\mp\gametypes\br_public::updatebrscoreboardstat( "isRespawning", 1 );
    var1 scripts\mp\weapons::deleteplacedequipment();
    var14 = scripts\mp\gametypes\br_public::relic_nuketimer_gettimeformission() / 1000;
    var15 = ref_125be( var1, 0, var14 );
    var16 = ref_1263e( var1, var15 );
    wait 2;
    
    if ( istrue( level.gulag.arenaflag ) )
    {
        thread calloutmarkerpingvo_canplaywithspamavoidance( var0.managevehiclehealthui.arenaflag, 0 );
    }
    
    var1 clearclienttriggeraudiozone( 2 );
    gulagfadetoblack( var1, 1 );
    wait 1;
    gulagwinnerrespawn( var1, var5, var4, var15, 1, var16, undefined, var6, var3, var7 );
}

// Params 1
// Size: 0x2c
function ref_1263e( var0 )
{
    var1 = scripts\mp\gametypes\br_public::ref_126b8( var0.origin, var0.height );
    self calloutmarkerping_getinventoryslot( 0 );
    scripts\mp\gametypes\br_public::ref_126b9( var1 );
    return var1;
}

// Params 2
// Size: 0x4d
function set_respawn_points( var0, var1 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "gulag_end" );
    self endon( "gulagLost" );
    self waittill( "death", var2 );
    
    if ( istrue( level.gulag.onekillwin ) )
    {
        handleonekillwin( var0, self, var2, var1 );
    }
    
    thread set_respawn_loc_delayed( var0 );
}

// Params 1
// Size: 0x25d
function set_respawn_loc_delayed( var0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "pull_out_of_gulag" );
    self notify( "gulagLost" );
    
    if ( istrue( self.gulagloser ) )
    {
        return;
    }
    
    self.gulagloser = 1;
    self.ref_136dc = var0.ref_136dc;
    thread ref_1268e( 1 );
    var0.jailedplayers = scripts\engine\utility::array_removeundefined( var0.jailedplayers );
    
    if ( var0.jailedplayers.size > 0 && getdvarint( "scr_br_fc_spectate_outlines", 0 ) )
    {
        self hudoutlinedisableforclients( var0.jailedplayers );
    }
    
    var0.arenaplayers = scripts\engine\utility::array_removeundefined( var0.arenaplayers );
    
    if ( var0.arenaplayers.size > 0 && getdvarint( "scr_br_fc_outline_countdown", 1 ) > 0 )
    {
        self hudoutlinedisableforclients( var0.arenaplayers );
    }
    
    var0.arenaplayers = scripts\engine\utility::array_remove( var0.arenaplayers, self );
    
    if ( isdefined( self ) )
    {
        var1 = self.name;
    }
    else
    {
        var1 = "<undefined>";
    }
    
    var2 = scripts\mp\music_and_dialog::reset_attack_next_available_time( "br_gulag_lose" );
    self setplayermusicstate( var2 );
    scripts\mp\weapons::deleteplacedequipment();
    scripts\mp\gametypes\br::ref_11b15( self, "gulagPlayerLost" );
    level thread scripts\mp\gametypes\br::ref_14006();
    scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "gulag_lose", self, 0, 1 );
    scripts\mp\gametypes\br_public::dmztutdropcash( "gulag_teammate_lose", self.team, self, 0, 0 );
    
    if ( isalive( self ) )
    {
        thread scripts\mp\gametypes\br_spectate::ref_13dc2();
        self.plotarmor = 1;
        self freezecontrols( 1 );
    }
    
    wait 2;
    self clearclienttriggeraudiozone( 2 );
    
    if ( istrue( level.gulag.arenaflag ) )
    {
        thread calloutmarkerpingvo_canplaywithspamavoidance( var1.managevehiclehealthui.arenaflag, 0 );
    }
    
    scripts\cp\vehicles\vehicle_compass_cp::ref_1203c( 2 );
    scripts\mp\gametypes\br_analytics::destroyaward( self, "loser" );
    playerdestroyhud( var1 );
    setplayervargulag( 0 );
    setplayervargulagarena( 0, 1 );
    ref_131aa( 0 );
    
    if ( isalive( self ) )
    {
        if ( !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "teamSpectate" ) )
        {
            scripts\mp\gametypes\br_spectate::ref_11be2( self, undefined, 1 );
        }
        
        gulagfadetoblack();
        wait 1;
        
        if ( !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "teamSpectate" ) )
        {
            scripts\mp\gametypes\br_spectate::ref_11be2( self, undefined, 1 );
        }
        
        if ( isalive( self ) )
        {
            var3 = spawnstruct();
            var3.origin = self.origin;
            var3.angles = self.angles;
            var3.attacker = self.lastattacker;
            self.health = 0;
            self notify( "death" );
            self notify( "death_or_disconnect" );
            scripts\mp\gametypes\br_spectate::spawnspectator( var3, 1, 1 );
            scripts\mp\playerlogic::removefromalivecount( 0, "gulagPlayerLost" );
        }
        
        gulagfadefromblack();
    }
    
    self.plotarmor = undefined;
}

// Params 1
// Size: 0x40
function ref_1268e( var0 )
{
    if ( istrue( level.usegulag ) )
    {
        if ( var0 )
        {
            self.ref_14439 = var0;
            self setclientomnvar( "ui_gulag", var0 );
        }
        else
        {
            self.ref_14439 = undefined;
            self setclientomnvar( "ui_gulag", 0 );
        }
        
        ref_131a1( var0 );
        return;
    }
}

// Params 0
// Size: 0x38
function ref_126aa()
{
    if ( istrue( level.usegulag ) && istrue( self.ref_14439 ) && scripts\mp\gametypes\br_public::rotationids( self.team, self.squadindex ) > 0 )
    {
        scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "gulag_buyback", self, 0, 1 );
        return;
    }
}

// Params 2
// Size: 0x2c
function ref_12aa8( var0, var1 )
{
    if ( istrue( var1.gulagarena ) )
    {
        var2 = var1.arena;
        var2.molotovs[ var2.molotovs.size ] = var0;
        return;
    }
}

// Params 2
// Size: 0x2c
function ref_12aaa( var0, var1 )
{
    if ( istrue( var1.gulagarena ) )
    {
        var2 = var1.arena;
        var2.ref_13b29[ var2.ref_13b29.size ] = var0;
        return;
    }
}

// Params 1
// Size: 0x7c
function handlesoloexclusionils( var0 )
{
    foreach ( var2 in var0.molotovs )
    {
        if ( isdefined( var2 ) )
        {
            thread scripts\mp\equipment\molotov::ref_11cb5( var2 );
        }
    }
    
    var0.molotovs = [];
    
    foreach ( var5 in var0.ref_13b29 )
    {
        if ( isdefined( var5 ) )
        {
            var5 thread scripts\mp\equipment\thermite::thermite_destroy();
        }
    }
    
    var0.ref_13b29 = [];
}

// Params 1
// Size: 0x3a, Type: bool
function set_relic_squadlink( var0 )
{
    var1 = isdefined( level.br_circle ) && isdefined( level.br_circle.safecircleent );
    
    if ( !var1 )
    {
        return true;
    }
    
    var2 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
    var3 = scripts\mp\gametypes\br_circle::getsafecircleradius();
    var4 = distance2d( var0, var2 );
    return var4 < var3;
}

// Params 1
// Size: 0x3a, Type: bool
function set_relic_shieldsonly( var0 )
{
    var1 = isdefined( level.br_circle ) && isdefined( level.br_circle.dangercircleent );
    
    if ( !var1 )
    {
        return true;
    }
    
    var2 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
    var3 = scripts\mp\gametypes\br_circle::getdangercircleradius();
    var4 = distance2d( var0, var2 );
    return var4 < var3;
}

// Params 2
// Size: 0xdb, Type: bool
function set_relic_rocket_kill_ammo( var0, var1 )
{
    if ( !scripts\mp\gametypes\br_c130::ispointinbounds( var0, 1 ) )
    {
        return false;
    }
    
    if ( !isdefined( level.br_circle ) || !isdefined( level.br_circle.safecircleent ) || !isdefined( level.br_circle.dangercircleent ) )
    {
        return true;
    }
    
    if ( scripts\mp\utility\game::round_vehicle_logic() == "truckwar" )
    {
        if ( set_relic_shieldsonly( var0 ) )
        {
            return true;
        }
    }
    else
    {
        if ( set_relic_squadlink( var0 ) )
        {
            return true;
        }
        
        if ( !set_relic_shieldsonly( var0 ) )
        {
            return false;
        }
    }
    
    if ( isdefined( var1 ) )
    {
        var2 = scripts\mp\gametypes\br_circle::getmintimetillpointindangercircle( var0 );
        
        if ( var1 > var2 )
        {
            return false;
        }
    }
    
    var3 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
    var4 = scripts\mp\gametypes\br_circle::getsafecircleradius();
    var5 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
    var6 = scripts\mp\gametypes\br_circle::getdangercircleradius();
    var7 = length( var5 - var3 );
    var8 = vectornormalize( var5 - var3 );
    var9 = level.ref_12ca0;
    var10 = var3 + var8 * var7 * var9;
    var11 = var4 + ( var6 - var4 ) * var9;
    var12 = distance2d( var0, var10 );
    return var12 < var11;
}

// Params 2
// Size: 0x41, Type: bool
function updateplayereliminatedomnvar( var0, var1 )
{
    if ( var0 == self )
    {
        return false;
    }
    
    if ( !isalive( var0 ) || var0 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() || istrue( var0.delay_enter_combat_after_investigating_grenade ) )
    {
        return false;
    }
    
    if ( !set_relic_rocket_kill_ammo( var0.origin, var1 ) )
    {
        return false;
    }
    
    return true;
}

// Params 3
// Size: 0x2f8
function ref_12568( var0, var1, var2 )
{
    var3 = undefined;
    
    if ( istrue( level.onlinegame ) && self getprivatepartysize() )
    {
        var4 = undefined;
        
        foreach ( var6 in self getfireteammembers() )
        {
            if ( !updateplayereliminatedomnvar( var6, var1 ) )
            {
                continue;
            }
            
            var4 = var6;
            
            if ( var6 isfireteamleader() )
            {
                break;
            }
        }
        
        if ( isdefined( var4 ) && istrue( var0 ) )
        {
            var3 = var4;
            var4 = undefined;
            
            foreach ( var6 in self getfireteammembers() )
            {
                if ( isdefined( var3 ) && var3 == var6 )
                {
                    continue;
                }
                
                if ( !updateplayereliminatedomnvar( var6, var1 ) )
                {
                    continue;
                }
                
                var4 = var6;
                
                if ( var6 isfireteamleader() )
                {
                    break;
                }
            }
        }
        
        if ( isdefined( var4 ) )
        {
            return var4;
        }
    }
    
    if ( isdefined( self.lastdeathpos ) )
    {
        var10 = undefined;
        var11 = undefined;
        var12 = scripts\mp\gametypes\br_public::rotationrefsbyseatandweapon( self.team, self.squadindex );
        
        foreach ( var14 in var12 )
        {
            if ( isdefined( var3 ) && var3 == var14 )
            {
                continue;
            }
            
            if ( !updateplayereliminatedomnvar( var14, var1 ) )
            {
                continue;
            }
            
            if ( var14 isparachuting() || var14 isskydiving() )
            {
                continue;
            }
            
            var15 = distance2dsquared( self.lastdeathpos, var14.origin );
            
            if ( !isdefined( var11 ) || var15 < var11 )
            {
                var10 = var14;
                var11 = var15;
            }
        }
        
        if ( isdefined( var10 ) && istrue( var0 ) && !isdefined( var3 ) )
        {
            var3 = var10;
            var10 = undefined;
            var11 = undefined;
            
            foreach ( var14 in var12 )
            {
                if ( isdefined( var3 ) && var3 == var14 )
                {
                    continue;
                }
                
                if ( !updateplayereliminatedomnvar( var14, var1 ) )
                {
                    continue;
                }
                
                if ( var14 isparachuting() || var14 isskydiving() )
                {
                    continue;
                }
                
                var15 = distance2dsquared( self.lastdeathpos, var14.origin );
                
                if ( !isdefined( var11 ) || var15 < var11 )
                {
                    var10 = var14;
                    var11 = var15;
                }
            }
        }
        
        if ( isdefined( var10 ) )
        {
            return var10;
        }
    }
    
    var10 = undefined;
    var19 = scripts\engine\utility::array_randomize( scripts\mp\gametypes\br_public::rotationrefsbyseatandweapon( self.team, self.squadindex ) );
    
    foreach ( var21 in var19 )
    {
        if ( isdefined( var3 ) && var3 == var21 )
        {
            continue;
        }
        
        if ( !updateplayereliminatedomnvar( var21, var1 ) )
        {
            continue;
        }
        
        var10 = var21;
        
        if ( istrue( var21 scripts\mp\gametypes\br_public::updatedragonsbreath() ) )
        {
            break;
        }
    }
    
    if ( isdefined( var10 ) )
    {
        return var10;
    }
    else if ( !istrue( var2 ) )
    {
        if ( scripts\mp\utility\game::round_vehicle_logic() == "dmz" || scripts\mp\utility\game::round_vehicle_logic() == "rat_race" || scripts\mp\utility\game::round_vehicle_logic() == "risk" || scripts\mp\utility\game::round_vehicle_logic() == "gold_war" )
        {
            var23 = scripts\mp\utility\teams::getteamdata( self.team, "teamCount" );
            
            if ( var23 == 1 && !istrue( self.locationtriggersetpaused ) && !scripts\mp\outofbounds::ispointinoutofbounds( self.origin ) )
            {
                return self;
            }
        }
    }
    
    return undefined;
}

// Params 3
// Size: 0x1b
function rocket_fuel_stability( var0, var1, var2 )
{
    var3 = ai_washitbyvehicle( var0, var1, var2 );
    scripts\mp\gametypes\br_analytics::detonatesound( var0, 0, var3 );
    return var3;
}

// Params 3
// Size: 0x155
function ai_washitbyvehicle( var0, var1, var2 )
{
    var3 = 3.14159;
    var4 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
    var5 = vectornormalize( var0 - var4 );
    var6 = vectortoangles( var5 );
    var7 = randomfloatrange( getdvarfloat( "scr_br_respawn_rand_ang_min", 10 ), getdvarfloat( "scr_br_respawn_rand_ang_max", 90 ) );
    var8 = scripts\mp\utility\game::round_vehicle_logic();
    
    if ( ( var8 == "dmz" || var8 == "rat_race" ) && getdvarint( "scr_dmz_respawn_rand_ang", 0 ) == 1 || var8 == "rumble_invasion" )
    {
        var9 = vectornormalize( anglestoforward( var6 + ( 0, scripts\engine\utility::ter_op( scripts\engine\utility::cointoss(), var7, var7 * -1 ), 0 ) ) );
    }
    else
    {
        var9 = var6;
    }
    
    var10 = var1 + var9 * var2;
    
    if ( set_relic_rocket_kill_ammo( var10, var3 ) )
    {
        return var10;
    }
    
    var9 *= -1;
    var10 = var1 + var9 * var2;
    
    if ( set_relic_rocket_kill_ammo( var10, var3 ) )
    {
        return var10;
    }
    
    var9 = vectornormalize( var5 - var1 );
    var10 = var1 + var9 * var2;
    
    if ( set_relic_rocket_kill_ammo( var10, var3 ) )
    {
        return var10;
    }
    
    var11 = var2;
    var12 = distance2d( var1, var5 );
    
    if ( var12 > 0 )
    {
        var13 = var11 / var12;
        
        if ( var13 > var4 )
        {
            var13 = var4;
        }
        
        var14 = var13 * 180 / var4;
        var10 = rotatepointaroundvector( ( 0, 0, 1 ), var1 - var5, var14 ) + var5;
        
        if ( set_relic_rocket_kill_ammo( var10, var3 ) )
        {
            return var10;
        }
    }
    
    var10 = scripts\mp\gametypes\br_circle::getrandompointincircle( var1, var2 );
    
    if ( set_relic_rocket_kill_ammo( var10, var3 ) )
    {
        return var10;
    }
    
    return undefined;
}

// Params 0
// Size: 0x1b9
function ref_12567()
{
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "missions" ) )
    {
        return undefined;
    }
    
    foreach ( var1 in level.questinfo.quests )
    {
        foreach ( var3 in var1.instances )
        {
            if ( var4 == self.team && !scripts\mp\gametypes\br_quest_util::upper_door_coll( var3 ) )
            {
                switch ( var3.category )
                {
                    case "assassination":
                        if ( isdefined( var3.targetplayer ) )
                        {
                            return var3.targetplayer.origin;
                        }
                        
                        break;
                    case "domination":
                        if ( isdefined( var3.ref_1393b ) && isdefined( var3.ref_1393b.domflag ) && isdefined( var3.ref_1393b.domflag.curorigin ) )
                        {
                            return var3.ref_1393b.domflag.curorigin;
                        }
                        
                        break;
                    case "lep":
                    case "scavenger_adler":
                    case "scavenger":
                        if ( isdefined( var3.ref_1393b.force_spawn_all_dead_players.origin ) && isdefined( var3.ref_1393b.force_spawn_all_dead_players ) )
                        {
                            return var3.ref_1393b.force_spawn_all_dead_players.origin;
                        }
                        
                        break;
                    case "x2_amb_signal":
                    case "x2_stash":
                    case "x2_map":
                    case "x2_signal":
                    case "x2_amb1":
                    case "x2_bomb":
                    case "x1fin":
                    case "history":
                    case "x1stash":
                    case "smokinggun":
                    case "vip":
                        break;
                    default:
                        break;
                }
            }
        }
    }
    
    return undefined;
}

// Params 1
// Size: 0x8f
function ref_12566( var0 )
{
    foreach ( var2 in level.br_pickups.crates )
    {
        if ( !isdefined( var2 ) || !isdefined( var2.team ) || var2.team != self.team )
        {
            continue;
        }
        
        if ( isdefined( var2.playerscaptured ) && isdefined( var2.playerscaptured[ self getentitynumber() ] ) )
        {
            continue;
        }
        
        if ( set_relic_rocket_kill_ammo( var2.origin, var0 ) )
        {
            return var2.origin;
        }
    }
}

// Params 1
// Size: 0x65
function playergetnearbybombsiteorigin( var0 )
{
    var1 = level.disable_super_in_turret.æ˝áÍÿ!S˘”?µ¬'YgÚÀ(IÍ√IÂ˚ò * level.disable_super_in_turret.æ˝áÍÿ!S˘”?µ¬'YgÚÀ(IÍ√IÂ˚ò;
    
    foreach ( var3 in level.disable_super_in_turret.£eEÚ©p∆£˙´Òr˜â ˙q·3õ )
    {
        if ( isdefined( var3 ) && distance2dsquared( var0, var3.origin ) <= var1 )
        {
            return var3.origin;
        }
    }
}

// Params 3
// Size: 0x7e5
function ref_125be( var0, var1, var2 )
{
    var3 = undefined;
    var4 = undefined;
    var5 = var2;
    var6 = 1;
    var7 = 0;
    
    if ( isdefined( self.setspawnpoint ) )
    {
        var3 = self.setspawnpoint.playerspawnpos;
        var4 = self.setspawnpoint.playerspawnangles;
    }
    
    var8 = getdvarfloat( "scr_br_respawnMaxLastDeathOffset", -1 );
    
    if ( !isdefined( var3 ) && var8 >= 0 && isdefined( self.lastdeathpos ) )
    {
        var9 = rocket_fuel_stability( self.lastdeathpos, var8, var1 );
        
        if ( isdefined( var9 ) )
        {
            var3 = scripts\mp\gametypes\br_public::modifyplayer_damage( var9 );
            var4 = registercarryobjectpickupcheck( var3, self.lastdeathpos );
        }
    }
    
    var8 = getdvarfloat( "scr_br_respawnMaxTeammateOffset", 1000 );
    
    if ( !isdefined( var3 ) && var8 >= 0 )
    {
        var10 = ref_12568( var0, var1 );
        
        if ( isdefined( var10 ) )
        {
            var11 = getdvarfloat( "scr_bmo_respawn_intermission_time", 5 ) * 1000;
            var12 = getdvarfloat( "scr_bmo_redeploy_window", 30 ) * 1000;
            
            if ( ( getdvar( "scr_br_gametype", "" ) == "dmz" || getdvar( "scr_br_gametype", "" ) == "rat_race" || getdvar( "scr_br_gametype", "" ) == "risk" || getdvar( "scr_br_gametype", "" ) == "kingslayer" || getdvar( "scr_br_gametype", "" ) == "gold_war" ) && isdefined( level.teamdata[ self.team ][ "lastParachuteTime" ] ) && level.teamdata[ self.team ][ "lastParachuteTime" ] + var12 > gettime() + var11 && distance2d( level.teamdata[ self.team ][ "lastParachuteOrigin" ], var10.origin ) < getdvarfloat( "scr_br_respawnMaxTeammateOffset", 1000 ) * 1.25 )
            {
                var3 = level.teamdata[ self.team ][ "lastParachuteOrigin" ];
                var4 = level.teamdata[ self.team ][ "lastParachuteAngles" ];
            }
            else
            {
                var3 = rocket_fuel_stability( var10.origin, var8, var1 );
                
                if ( isdefined( var3 ) )
                {
                    var3 = scripts\mp\gametypes\br_public::modifyplayer_damage( var3 );
                    var4 = registercarryobjectpickupcheck( var3, var10.origin );
                    level.teamdata[ self.team ][ "lastParachuteOrigin" ] = var3;
                    level.teamdata[ self.team ][ "lastParachuteAngles" ] = var4;
                    level.teamdata[ self.team ][ "lastParachuteTime" ] = gettime();
                }
            }
            
            if ( isdefined( var3 ) && isdefined( level.ref_12ca9 ) && level.ref_12ca9 >= 0 )
            {
                var13 = getclosestpointonnavmesh( var3 );
                var14 = var13 - var3;
                
                if ( length2d( var14 ) > level.ref_12ca9 )
                {
                    var14 = vectornormalize( var14 );
                    var14 = ( var14[ 0 ] * level.ref_12ca9, var14[ 1 ] * level.ref_12ca9, var14[ 2 ] * level.ref_12ca9 );
                    var3 = var13 + var14;
                }
            }
        }
    }
    
    var8 = getdvarfloat( "scr_br_respawnMaxMissionOffset", 3000 );
    
    if ( !isdefined( var3 ) && var8 >= 0 )
    {
        var15 = ref_12567();
        
        if ( isdefined( var15 ) )
        {
            var3 = rocket_fuel_stability( var15, var8, var1 );
            var4 = registercarryobjectpickupcheck( var3, var15 );
        }
    }
    
    var8 = getdvarfloat( "scr_br_respawnMaxCrateOffset", 3000 );
    
    if ( !isdefined( var3 ) && var8 >= 0 )
    {
        var16 = ref_12566( var1 );
        
        if ( isdefined( var16 ) )
        {
            var3 = rocket_fuel_stability( var16, var8, var1 );
            var4 = registercarryobjectpickupcheck( var3, var16 );
        }
    }
    
    if ( scripts\mp\utility\game::round_vehicle_logic() == "olaride" && issquadwiped( self.team ) )
    {
        var17 = self.origin;
        
        if ( isdefined( self.lastdeathpos ) )
        {
            var17 = self.lastdeathpos;
        }
        
        var18 = playergetnearbybombsiteorigin( var17 );
        
        if ( !isdefined( var18 ) )
        {
            var18 = var17;
        }
        
        var8 = level.disable_super_in_turret.ã‹S·@%ç˚„ã≈•;p¯Mùô`‚jUÉÔÔ;
        var3 = rocket_fuel_stability( var18, var8, var1 );
        var4 = registercarryobjectpickupcheck( var3, var18 );
    }
    
    if ( !isdefined( var3 ) )
    {
        if ( isdefined( level.br_circle ) && isdefined( level.br_circle.safecircleent ) )
        {
            if ( getdvarint( "scr_br_useClosestSafePointFromSquadmate", 0 ) )
            {
                var19 = getdvarfloat( "scr_br_closestSafePointTimeOffset", 2 );
                var3 = scripts\mp\gametypes\br_circle::helibankplunder( self, var1, var19 );
            }
            
            if ( !isdefined( var3 ) )
            {
                var20 = getdvarfloat( "scr_br_useClosestSafePerimeterPointRadiusPct", 0.9 );
                
                if ( getdvarint( "scr_br_useClosestSafePerimeterPointFromSquadmate", 1 ) )
                {
                    var3 = scripts\mp\gametypes\br_circle::closestsafeperimeterpointfromsquadmate( var20, var1 );
                }
                
                if ( !isdefined( var3 ) && getdvarint( "scr_br_useClosestSafePerimeterPointFromLoadout", 1 ) )
                {
                    var3 = scripts\mp\gametypes\br_circle::closestsafeperimeterpointfromloadout( var20, var1 );
                }
                
                if ( isdefined( var3 ) )
                {
                    var4 = registercarryobjectpickupcheck( scripts\mp\gametypes\br_circle::getsafecircleorigin(), var3 );
                    var21 = 0;
                    
                    if ( getdvarint( "scr_br_useClosestSafePerimeterPerpendicularFacing", 1 ) )
                    {
                        var22 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
                        var23 = randomint( 2 );
                        var24 = [ 90, -90 ];
                        var25 = [ -10, 10 ];
                        var26 = rotatevector( var3 - var22, ( 0, var25[ var23 ], 0 ) ) + var22;
                        var27 = scripts\mp\gametypes\br_circle::vandalize_minigun_speed( var26, 0, var1 );
                        
                        if ( var27 == 0 )
                        {
                            var23 = 1 - var23;
                            var26 = rotatevector( var3 - var22, ( 0, var25[ var23 ], 0 ) ) + var22;
                            var27 = scripts\mp\gametypes\br_circle::vandalize_minigun_speed( var26, 0, var1 );
                        }
                        
                        if ( var27 )
                        {
                            var3 = var26;
                            var21 = var24[ var23 ];
                        }
                    }
                    
                    var28 = angleclamp( var4[ 1 ] + var21 );
                    var4 = ( 0, var28, 0 );
                }
            }
            
            if ( !isdefined( var3 ) )
            {
                var29 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
                var30 = scripts\mp\gametypes\br_circle::getsafecircleradius();
                var31 = getdvarfloat( "scr_br_minRespawnRadiusPct", 0.9 );
                var20 = getdvarfloat( "scr_br_maxRespawnRadiusPct", 0.9 );
                var32 = getdvarint( "scr_br_maxRespawnDropToGround", 1 );
                var33 = getdvarint( "scr_br_maxRespawnSnapToNavMesh", 1 );
                
                if ( getdvarint( "scr_br_respawn_one_circle_fallback", 1 ) && var30 == 0 )
                {
                    var34 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
                    var35 = scripts\mp\gametypes\br_circle::getdangercircleradius();
                    
                    if ( var35 > 0 )
                    {
                        var29 = var34;
                        var30 = var35;
                        var31 = getdvarfloat( "scr_br_minRespawnRadiusPct_fallback", 0.6 );
                        var20 = getdvarfloat( "scr_br_maxRespawnRadiusPct_fallback", 0.8 );
                        var7 = 1;
                    }
                }
                
                var3 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent( var29, var30, var31, var20, var32, var33, 0, var1 );
            }
        }
        else if ( isdefined( level.prematchspawnorigins ) )
        {
            if ( isdefined( level.teamdata[ self.team ][ "chosenSpawnWipeOrigin" ] ) && isdefined( level.teamdata[ self.team ][ "spawnWipeOriginUseStartTime" ] ) && isdefined( level.checkpoint_objective_id ) && level.teamdata[ self.team ][ "spawnWipeOriginUseStartTime" ] + level.checkpoint_objective_id * 1000 > gettime() )
            {
                var3 = level.teamdata[ self.team ][ "chosenSpawnWipeOrigin" ];
            }
            else
            {
                var36 = [];
                
                foreach ( var38 in level.prematchspawnorigins )
                {
                    if ( distance2dsquared( var38.origin, self.origin ) > var8 )
                    {
                        var36 = var38;
                    }
                }
                
                if ( var36.size == 0 )
                {
                    var36 = level.prematchspawnorigins;
                }
                
                var36 = scripts\engine\utility::array_randomize( var36 );
                
                if ( ( getdvar( "scr_br_gametype", "" ) == "dmz" || getdvar( "scr_br_gametype", "" ) == "gold_war" ) && isdefined( level.ref_12ca7 ) && istrue( self.ref_13749 ) )
                {
                    var3 = ( var36[ 0 ].origin[ 0 ], var36[ 0 ].origin[ 1 ], level.ref_12ca7 );
                }
                else
                {
                    var3 = var36[ 0 ].origin;
                }
                
                var3 += scripts\engine\math::random_vector_2d() * randomfloatrange( 100, 500 );
                level.teamdata[ self.team ][ "chosenSpawnWipeOrigin" ] = var3;
                level.teamdata[ self.team ][ "spawnWipeOriginUseStartTime" ] = gettime();
            }
            
            var4 = ( 0, 0, 0 );
            
            if ( var3[ 2 ] > 10000 & !isdefined( var2 ) )
            {
                var6 = 0;
                var5 = scripts\mp\gametypes\br_public::getinfilspawnoffset();
            }
        }
        else
        {
            var3 = ( 0, 0, 0 );
            var4 = ( 0, 0, 0 );
        }
    }
    
    if ( !isdefined( var4 ) )
    {
        if ( var7 )
        {
            var40 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
        }
        else
        {
            var40 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
        }
        
        var41 = vectortoyaw( var40 - var4 );
        var5 = ( 0, var41, 0 );
    }
    
    if ( var7 )
    {
        if ( !isdefined( var6 ) )
        {
            var6 = scripts\cp_mp\parachute::getc130height();
        }
        
        if ( isdefined( level.br_circle ) )
        {
            var42 = level.br_circle.circleindex;
            var43 = remove_engineer_class();
            var44 = isdefined( var42 ) && var42 >= var43;
            
            if ( var44 )
            {
                var6 *= getdvarfloat( "scr_br_gulagClosedSpawnOffsetScaler", 0.55 );
            }
        }
        
        if ( isdefined( level.ref_12ca7 ) )
        {
            var6 = level.ref_12ca7;
        }
        
        var45 = ( 0, 0, var6 );
        var4 = scripts\mp\gametypes\br::resetcircuitbreakers( var4, var45 );
    }
    
    var46 = spawnstruct();
    var46.origin = var4;
    var46.angles = var5;
    var46.height = var6;
    return var46;
}

// Params 2
// Size: 0x21
function registercarryobjectpickupcheck( var0, var1 )
{
    if ( isdefined( var0 ) && isdefined( var1 ) )
    {
        var2 = vectortoyaw( var1 - var0 );
        var3 = ( 0, var2, 0 );
        return var3;
    }
}

// Params 11
// Size: 0x535
function gulagwinnerrespawn( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10 )
{
    var11 = !istrue( var0 );
    
    if ( !istrue( var0 ) && !istrue( var8 ) )
    {
        scripts\cp\vehicles\vehicle_compass_cp::ref_1203c( 1 );
    }
    
    if ( !isdefined( var10 ) )
    {
        var10 = 0;
    }
    
    if ( isdefined( var1 ) )
    {
        scripts\mp\gametypes\br_analytics::destroyaward( self, var1 );
    }
    
    ref_1268e( 0 );
    setplayervargulag( 0 );
    setplayervargulagarena( 0 );
    
    if ( scripts\mp\utility\game::getgametype() == "br" )
    {
        playerdestroyhud( self.arena );
    }
    
    ref_131aa( 0 );
    level notify( "update_circle_hide" );
    self.vehicle_compass_friendlystatuschangedcallback = undefined;
    scripts\mp\gametypes\br::scriptednode( self );
    playertakeawayrock( self.arena );
    set_showing_bomb_wire_pair_to_player( var0 );
    
    if ( isdefined( level.gulag ) && istrue( level.gulag.planerespawn ) )
    {
        playerrespawngulagcleanup( var0 );
        set_scriptable_states();
        playersetupac130();
        
        if ( isdefined( self.oobimmunity ) )
        {
            scripts\mp\outofbounds::disableoobimmunity( self );
        }
        
        return;
    }
    
    if ( !isdefined( var2 ) )
    {
        var2 = ref_125be();
    }
    
    var12 = var2.origin;
    var13 = var2.angles;
    var14 = var12;
    
    if ( isdefined( var4 ) )
    {
        var14 = var4;
    }
    
    set_scriptable_states();
    ref_126c3( var14, var13 );
    var15 = spawn( "script_model", var14 );
    var15 setmodel( "tag_origin" );
    var15.angles = var13;
    var15 hide();
    var15 showtoplayer( self );
    self playerlinktoabsolute( var15, "tag_origin" );
    self playerhide();
    thread ref_12524( var15 );
    waitframe();
    
    if ( isdefined( self.oobimmunity ) )
    {
        scripts\mp\outofbounds::disableoobimmunity( self );
    }
    
    playerrespawngulagcleanup( var0 );
    
    if ( getdvarint( "scr_skip_respawn_gate", 1 ) == 0 )
    {
        scripts\mp\gametypes\br_public::ref_126ed();
    }
    
    scripts\mp\gametypes\br_public::ref_1252b();
    
    if ( isdefined( var4 ) )
    {
        var15.origin = var12;
    }
    
    var15 playsoundtoplayer( "br_ac130_flyby", self );
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
    self playershow( 1 );
    ref_125bf( 1 );
    var16 = 0;
    
    if ( isdefined( level.ref_121cc ) )
    {
        var16 = level.ref_121cc;
    }
    
    if ( !scripts\mp\gametypes\br_public::uniquelootitemid() )
    {
        if ( istrue( level.ref_13678 ) )
        {
            self [[ level.parachuterestoreweaponscb ]]();
        }
        else
        {
            thread scripts\cp_mp\parachute::startfreefall( var16, 0, undefined, undefined, 1 );
        }
    }
    
    if ( !istrue( var3 ) )
    {
        thread ref_13dcb( 7 );
    }
    
    if ( istrue( var5 ) )
    {
        self setclientomnvar( "ui_br_transition_type", 0 );
    }
    
    if ( scripts\mp\utility\game::getgametype() == "br" )
    {
        self setclientomnvar( "ui_show_spectateHud", -1 );
    }
    
    ref_12c7a();
    var17 = scripts\mp\utility\perk::_hasperk( "specialty_br_reinforced" );
    scripts\mp\gametypes\br_armor::searchcirclesize( var17 );
    scripts\mp\gametypes\br_quest_util::ref_12072();
    scripts\mp\gametypes\br_rewards::ref_12072();
    scripts\mp\gametypes\br_alt_mode_escape::obj_hangar_juggs();
    scripts\mp\gametypes\br_gametypes::ref_12e05( "gulagWinnerRespawn", self );
    wait 0.5;
    
    if ( scripts\mp\utility\game::getgametype() == "br" && !isdefined( self.ref_145bf ) )
    {
        gulagfadefromblack();
    }
    
    waitframe();
    var15 delete();
    _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs( "gulag" );
    
    if ( istrue( level.ref_133ef ) )
    {
        scripts\mp\gametypes\br_skydive_protection::toma_strike_munitionused( 1 );
    }
    
    if ( scripts\mp\gametypes\br_public::tutorial_playsound() )
    {
        self notify( "respawn_from_gulag" );
    }
    
    self notify( "can_show_splashes" );
    
    if ( istrue( getdvar( "scr_br_gametype", "" ) == "truckwar" ) && !istrue( var8 ) )
    {
        var18 = "br_gulag_winner_redeploy_mogulag";
        var19 = undefined;
    }
    
    if ( istrue( getdvar( "scr_br_gametype", "" ) == "dmz" ) || istrue( getdvar( "scr_br_gametype", "" ) == "rat_race" ) || istrue( getdvar( "scr_br_gametype", "" ) == "kingslayer" ) || istrue( getdvar( "scr_br_gametype", "" ) == "rumble" ) || istrue( getdvar( "scr_br_gametype", "" ) == "risk" ) || istrue( getdvar( "scr_br_gametype", "" ) == "sandbox" ) || istrue( getdvar( "scr_br_gametype", "" ) == "rumble_invasion" ) || istrue( getdvar( "scr_br_gametype", "" ) == "gold_war" ) )
    {
        var18 = "br_gulag_winner_redeploy_mogulag";
        var19 = undefined;
    }
    else if ( istrue( var9 ) )
    {
        var18 = "br_gulag_jailbreak_redeploy";
        var19 = undefined;
    }
    else if ( ( istrue( var4 ) || istrue( var12 ) ) && !var14 )
    {
        var18 = "br_gulag_kiosk_redeploy";
        var19 = var10;
    }
    else
    {
        if ( istrue( isdefined( level.gulag ) && !istrue( level.gulag.shutdown ) ) && checkgulagusecount() )
        {
            var18 = "br_gulag_winner_redeploy_mogulag";
        }
        else
        {
            var18 = "br_gulag_winner_redeploy";
        }
        
        var19 = undefined;
    }
    
    if ( !istrue( var16 ) )
    {
        thread scripts\mp\hud_message::showsplash( var18, undefined, var19 );
    }
    
    if ( istrue( self.ref_145bf ) && isdefined( level.br_circle ) )
    {
        self.ref_145bf = undefined;
        
        if ( istrue( self.ref_12c9e ) )
        {
            playerrespawngulagcleanup( var7 );
            set_scriptable_states();
            _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs( "gulag" );
            
            if ( isdefined( self.oobimmunity ) )
            {
                scripts\mp\outofbounds::disableoobimmunity( self );
            }
        }
        
        ref_1268c();
    }
    
    if ( isdefined( level.gulag ) && istrue( level.gulag.shutdown ) && !istrue( self.gulagdone ) )
    {
        wait 2;
        playergulagdonesplash();
    }
    
    if ( var17 )
    {
        scripts\mp\gametypes\br::ref_13f21( self, "gulagWinnerRespawn-token" );
        level thread scripts\mp\gametypes\br::ref_14006();
    }
    
    var20 = "undefined";
    
    if ( isdefined( self.currentweapon ) )
    {
        var20 = self.currentweapon.basename;
    }
    
    var21 = "undefined";
    
    if ( isdefined( self.name ) )
    {
        var21 = self.name;
    }
    
    logstring( "[FD] Finished respawning in fd for player: " + var21 + " with weapon: " + var20 );
}

// Params 1
// Size: 0x1e
function ref_12524( var0 )
{
    var0 endon( "death" );
    self waittill( "disconnect" );
    
    if ( isdefined( var0 ) )
    {
        var0 delete();
        return;
    }
}

// Params 1
// Size: 0x1e
function ref_125bf( var0 )
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

// Params 1
// Size: 0x22
function ref_13dcb( var0 )
{
    self endon( "disconnect" );
    var1 = scripts\mp\gametypes\br_gametypes::ref_12e05( "triggerRespawnOverlay" );
    
    if ( istrue( var1 ) )
    {
        return;
    }
    
    ref_13dcc();
}

// Params 0
// Size: 0x29
function ref_13dcc()
{
    wait 0.5;
    
    if ( istrue( self.ref_145bf ) )
    {
        thread scripts\mp\hud_message::showsplash( "br_gulag_respawn_in_fd" );
        return;
    }
    
    thread scripts\mp\hud_message::showsplash( "br_gulag_winner" );
}

// Params 1
// Size: 0x76
function playerrespawngulagcleanup( var0 )
{
    self notify( "gulagRespawn" );
    scripts\mp\equipment\molotov::molotov_clear_burning();
    
    if ( getdvarint( "scr_br_gulag_cleanup_killswitch", 0 ) == 0 )
    {
        self.shouldhumanspawntags = 0;
    }
    
    self.health = self.maxhealth;
    scripts\mp\healthoverlay::onexitdeathsdoor( 1 );
    
    if ( !istrue( var0 ) )
    {
        scripts\mp\utility\player::enableplayerforspawnlogic( 0 );
        self setclientomnvar( "ui_gulag", 0 );
        scripts\mp\gametypes\br_public::updatebrscoreboardstat( "isRespawning", 0 );
        
        if ( isdefined( self.arena ) )
        {
            removeloadingplayer( self.arena, self );
        }
        
        self.arena = undefined;
        return;
    }
}

// Params 1
// Size: 0x75
function set_showing_bomb_wire_pair_to_player( var0 )
{
    var1 = getdvarint( "scr_br_fc_keep_gun", 1 ) != 0;
    var2 = istrue( level.debug_safehouse_regroup_start ) && !istrue( level.debug_show2dvotext );
    var3 = !istrue( var0 );
    
    if ( var1 && var3 && !var2 )
    {
        return gulagwinnerremembergunandammo();
    }
    
    var4 = getdvarint( "scr_br_fc_loadouts", 1 ) != 0 && getdvarint( "scr_br_fc_winner_loadout", -1 ) > -1;
    
    if ( isdefined( level.deletescriptableinstanceaftertime ) || var4 )
    {
        self.set_shouldrespawn = 1;
        return;
    }
    
    self.set_shouldrespawn = 0;
}

// Params 0
// Size: 0x74
function set_solution()
{
    if ( !istrue( level.usegulag ) && !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "gulagWinnerRestoreLoadoutUseGulag" ) )
    {
        return 0;
    }
    
    var0 = getdvarint( "scr_br_fc_keep_gun", 1 ) != 0;
    var1 = !istrue( self.gulagloser );
    
    if ( var0 && var1 )
    {
        return set_slow_healthregen();
    }
    
    var2 = getdvarint( "scr_br_fc_loadouts", 1 ) != 0 && getdvarint( "scr_br_fc_winner_loadout", -1 ) > -1;
    
    if ( isdefined( level.deletescriptableinstanceaftertime ) || var2 )
    {
        return set_spawn_scoring_params_for_level();
    }
    
    return 0;
}

// Params 0
// Size: 0x169
function gulagwinnerremembergunandammo()
{
    self.br_gulagguncurrent = self getcurrentprimaryweapon();
    var0 = self getweaponslistprimaries();
    var0 = scripts\engine\utility::array_remove( var0, getcompleteweaponname( "iw8_knifestab_mp" ) );
    var0 = scripts\engine\utility::array_remove( var0, getcompleteweaponname( "iw8_throwingknife_fire_melee_mp" ) );
    var0 = scripts\engine\utility::array_remove( var0, getcompleteweaponname( "iw8_throwingknife_electric_melee_mp" ) );
    var0 = scripts\engine\utility::array_remove( var0, getcompleteweaponname( "iw8_throwingknife_drill_melee_mp" ) );
    var0 = scripts\engine\utility::array_remove( var0, getcompleteweaponname( "iw8_fists_mp" ) );
    self.br_gulagguns = [];
    self.br_gulagammo = [];
    
    foreach ( var2 in var0 )
    {
        var3 = createheadicon( var2 );
        
        if ( getsubstr( var3, 0, 4 ) == "alt_" )
        {
            continue;
        }
        
        self.br_gulagguns[ self.br_gulagguns.size ] = var2;
        
        if ( getdvarint( "scr_br_gulag_rememberammo", 0 ) == 1 )
        {
            self.br_gulagammo[ var3 ] = self getweaponammoclip( var2 ) + self getweaponammostock( var2 );
            continue;
        }
        
        self.br_gulagammo[ var3 ] = weaponclipsize( var2 ) * 3;
    }
    
    var5 = self getweaponslistoffhands();
    var6 = "primary";
    self.br_gulagoffhands = [];
    
    foreach ( var8 in var5 )
    {
        var9 = self getweaponammoclip( var8 );
        
        if ( var9 <= 0 )
        {
            scripts\mp\equipment::takeequipment( var6 );
            var6 = "secondary";
            continue;
        }
        
        var6 = "secondary";
        self.br_gulagoffhands[ self.br_gulagoffhands.size ] = var8;
        var10 = createheadicon( var8 );
        self.br_gulagammo[ var10 ] = weaponstartammo( var8 );
    }
}

// Params 0
// Size: 0x246, Type: bool
function set_slow_healthregen()
{
    if ( isdefined( self.br_gulagguns ) && isdefined( self.br_gulagoffhands ) && isdefined( self.br_gulagammo ) )
    {
        var0 = getdvarint( "scr_br_shutdownloadout", 1 ) == 1;
        
        if ( var0 && self.br_gulagguns.size < 1 )
        {
            self.set_shouldrespawn = 1;
            set_spawn_scoring_params_for_level();
            return false;
        }
        
        self takeallweapons();
        scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
        self.equipment[ "primary" ] = undefined;
        self.equipment[ "secondary" ] = undefined;
        self.equipment[ "health" ] = undefined;
        self.equipment[ "super" ] = undefined;
        var1 = 0;
        
        foreach ( var3 in self.br_gulagguns )
        {
            var4 = createheadicon( var3 );
            scripts\cp_mp\utility\inventory_utility::_giveweapon( var3 );
            self setweaponammostock( var3, 0 );
            
            if ( !var1 )
            {
                self assignweaponprimaryslot( var4 );
                scripts\cp_mp\utility\inventory_utility::_switchtoweapon( var3 );
                var1 = 1;
            }
            
            scripts\mp\weapons::fixupplayerweapons( self, var4 );
            thread scripts\mp\gametypes\br_respawn::giveweaponpickup( var4 );
            var5 = weaponclipsize( var3 );
            var6 = int( min( var5, 25 ) );
            
            if ( isdefined( self.br_gulagammo[ var4 ] ) )
            {
                var6 = int( max( var6, self.br_gulagammo[ var4 ] ) );
            }
            
            var7 = 0;
            
            if ( var6 > var5 )
            {
                var7 = var6 - var5;
                var6 = var5;
            }
            
            self setweaponammoclip( var3, var6 );
            
            if ( var7 > 0 )
            {
                var8 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon( var3 );
                scripts\mp\gametypes\br_weapons::br_ammo_give_type( self, var8, var7 );
            }
        }
        
        scripts\mp\gametypes\br_weapons::br_ammo_update_weapons( self );
        
        if ( self.br_gulagguns.size < 2 )
        {
            self giveweapon( getcompleteweaponname( "iw8_fists_mp" ) );
        }
        
        foreach ( var11 in self.br_gulagoffhands )
        {
            var12 = scripts\mp\equipment::getequipmentreffromweapon( var11 );
            
            if ( isdefined( var12 ) && isdefined( level.br_pickups.br_equipnametoscriptable[ var12 ] ) )
            {
                var13 = level.br_pickups.br_equipnametoscriptable[ var12 ];
                scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem( self, var13, 1 );
                var4 = createheadicon( var11 );
                
                if ( isdefined( self.br_gulagammo[ var4 ] ) )
                {
                    var14 = self.br_gulagammo[ var4 ];
                    self setweaponammoclip( var11, var14 );
                }
            }
        }
        
        if ( isdefined( self.br_gulagguncurrent ) )
        {
            self switchtoweaponimmediate( self.br_gulagguncurrent );
        }
        
        if ( isdefined( self.executionref ) )
        {
            scripts\cp_mp\execution::_giveexecution( self.executionref );
        }
        
        self.br_gulaggun = undefined;
        self.br_gulagammo = undefined;
        self.br_gulagoffhands = undefined;
        self.br_gulagguncurrent = undefined;
        return true;
    }
    else if ( istrue( self.gulagloser ) )
    {
        self.shouldhumanspawntags = 0;
    }
    
    return false;
}

// Params 0
// Size: 0xf9, Type: bool
function set_spawn_scoring_params_for_level()
{
    if ( istrue( self.set_shouldrespawn ) )
    {
        var0 = getdvarint( "scr_br_fc_winner_loadout", -1 );
        
        if ( var0 > -1 )
        {
            self.pers[ "gamemodeLoadout" ] = level.set_relic_thirdperson[ var0 ];
        }
        else
        {
            self.pers[ "gamemodeLoadout" ] = level.deletescriptableinstanceaftertime;
        }
        
        self.class = "gamemode";
        self.prevweaponobj = undefined;
        var1 = scripts\mp\class::loadout_getclassstruct();
        var1 = scripts\mp\class::loadout_updateclass( var1, "gamemode" );
        scripts\mp\class::preloadandqueueclassstruct( var1, 1, 1 );
        scripts\mp\class::giveloadout( self.team, "gamemode", 0, 0 );
        self givestartammo( var1.loadoutprimaryobject );
        
        if ( isdefined( var1.loadoutsecondaryobject ) )
        {
            self givestartammo( var1.loadoutsecondaryobject );
        }
        
        scripts\mp\gametypes\br::scriptednode( self );
        scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
        scripts\mp\gametypes\br_weapons::delay_add_to_chopper_boss_drone_target_array();
        scripts\mp\gametypes\br_weapons::br_ammo_update_weapons( self );
        self notify( "ammo_update" );
        thread scripts\mp\gametypes\br::defend_wave_2();
        
        if ( isdefined( level.obit_activation ) && level.obit_activation.ref_129da == 1 )
        {
            scripts\mp\gametypes\br::disablearmorykiosk();
        }
        
        self.set_shouldrespawn = undefined;
        return true;
    }
    
    return false;
}

// Params 1
// Size: 0x26
function popnextmatch( var0 )
{
    var1 = var0.matches[ 0 ];
    var0.matches = scripts\engine\utility::array_remove_index( var0.matches, 0 );
    return var1;
}

// Params 0
// Size: 0x37, Type: bool
function checkgulagusecount()
{
    if ( level.gulag.maxuses >= 0 )
    {
        var0 = self.gulaguses;
        
        if ( !isdefined( var0 ) )
        {
            var0 = 0;
        }
        
        if ( var0 >= level.gulag.maxuses )
        {
            return false;
        }
    }
    
    return true;
}

// Params 0
// Size: 0x69, Type: bool
function trygulagspawn()
{
    if ( !istrue( self.br_infilstarted ) || !scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        return false;
    }
    
    if ( istrue( self.gulag ) )
    {
        return false;
    }
    
    if ( scripts\mp\gametypes\br_public::hasrespawntoken() && !scripts\mp\gametypes\br_pickups::ref_12cb6() )
    {
        thread playergulagautowin( "tryGulagSpawn", undefined, 1, 1 );
        return true;
    }
    
    if ( !ref_12517() )
    {
        return false;
    }
    
    if ( scripts\mp\gametypes\br_public::hasgulagtoken() )
    {
        scripts\mp\gametypes\br_pickups::removegulagtoken();
    }
    
    thread initplayerjail( 1 );
    return true;
}

// Params 0
// Size: 0x6e, Type: bool
function ref_12517()
{
    if ( !istrue( self.br_infilstarted ) || !scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        return false;
    }
    
    if ( istrue( self.gulag ) )
    {
        return false;
    }
    
    if ( !istrue( level.usegulag ) )
    {
        return false;
    }
    
    if ( istrue( level.gulag.shutdown ) && !ref_125e6() )
    {
        return false;
    }
    
    if ( getdvarint( "scr_br_all_assassin_version", 0 ) )
    {
        return false;
    }
    
    if ( !checkgulagusecount() && !scripts\mp\gametypes\br_public::hasgulagtoken() )
    {
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0x94
function playergulaghud( var0 )
{
    if ( isdefined( var0.fightover ) && !var0.fightover )
    {
        ref_1267a( var0 );
    }
    
    if ( isdefined( var0.fightover ) && !var0.fightover && isdefined( var0.time ) && var0.time > 0 )
    {
        var1 = var0.time;
        
        if ( !istrue( var0.overtime ) )
        {
            var2 = respawn_scriptible_carriable_wait();
            var1 -= var2;
        }
        
        self setclientomnvar( "ui_br_gulag_match_end_time", gettime() + int( var1 * 1000 ) );
        return;
    }
    
    self setclientomnvar( "ui_br_gulag_match_end_time", 0 );
}

// Params 2
// Size: 0x21
function updatematchtimerhud( var0, var1 )
{
    _updatematchtimerhudinternal( var0.arenaplayers, var1 );
    _updatematchtimerhudinternal( var0.jailedplayers, var1 );
}

// Params 2
// Size: 0x5c
function _updatematchtimerhudinternal( var0, var1 )
{
    foreach ( var3 in var0 )
    {
        if ( !isdefined( var3 ) )
        {
            continue;
        }
        
        if ( var1 > 0 )
        {
            var3 setclientomnvar( "ui_br_gulag_match_end_time", gettime() + int( var1 * 1000 ) );
            continue;
        }
        
        var3 setclientomnvar( "ui_br_gulag_match_end_time", 0 );
    }
}

// Params 1
// Size: 0x14c
function updatematchqueuepositions( var0 )
{
    var1 = 2;
    
    while ( var1 <= level.gulag.maxplayers )
    {
        var2 = [];
        
        foreach ( var4 in var0.jailedplayers )
        {
            if ( !isdefined( var4 ) )
            {
                continue;
            }
            
            var5 = 0;
            
            foreach ( var12, var7 in var2 )
            {
                if ( var7.size >= var1 )
                {
                    continue;
                }
                
                var8 = 0;
                
                foreach ( var10 in var7 )
                {
                    if ( var10.team == var4.team )
                    {
                        var8 = 1;
                        break;
                    }
                }
                
                if ( !var8 )
                {
                    var5 = 1;
                    var4.gulagposition = var12 + 1;
                    var2[ var2[ var12 ].size ] = var4;
                    break;
                }
            }
            
            if ( !var5 )
            {
                var4.gulagposition = var2.size + 1;
                var2 = [ var4 ];
            }
        }
        
        var0.matches = var2;
        
        if ( var2.size <= level.gulag.maxqueue )
        {
            break;
        }
        
        var1 += 2;
    }
    
    ref_13fc1( var0 );
}

// Params 1
// Size: 0xab
function playerwatchdisconnect( var0 )
{
    self endon( "gulagLost" );
    self endon( "gulag_end" );
    self waittill( "death_or_disconnect" );
    
    if ( isdefined( self ) && istrue( self.gulagarena ) )
    {
        return;
    }
    
    if ( isdefined( self ) )
    {
        if ( istrue( self.gulagarena ) )
        {
            var0.arenaplayers = scripts\engine\utility::array_remove( var0.arenaplayers, self );
        }
        else if ( istrue( self.jailed ) )
        {
            var0.jailedplayers = scripts\engine\utility::array_remove( var0.jailedplayers, self );
        }
        
        playerdestroyhud( var0 );
    }
    else
    {
        var0.jailedplayers = scripts\engine\utility::array_removeundefined( var0.jailedplayers );
        var0.arenaplayers = scripts\engine\utility::array_removeundefined( var0.arenaplayers );
    }
    
    updatematchqueuepositions( var0 );
}

// Params 1
// Size: 0x33
function playerdestroyhud( var0 )
{
    self setclientomnvar( "ui_br_gulag_match_end_time", 0 );
    
    if ( isdefined( var0 ) )
    {
        ref_12526( var0 );
    }
    
    if ( isdefined( self.gulagjailbreakhud ) )
    {
        self.gulagjailbreakhud destroy();
    }
    
    self.set_relic_team_proximity = undefined;
}

// Params 1
// Size: 0x26
function setplayervargulag( var0 )
{
    if ( isdefined( self.gulag ) && self.gulag == var0 )
    {
        return;
    }
    
    self.gulag = var0;
    level notify( "update_circle_hide" );
}

// Params 2
// Size: 0x33
function setplayervargulagarena( var0, var1 )
{
    if ( isdefined( self.gulagarena ) && self.gulagarena == var0 )
    {
        return;
    }
    
    if ( !istrue( var1 ) )
    {
        ref_131a1( var0 );
    }
    
    self.gulagarena = var0;
    level notify( "update_circle_hide" );
}

// Params 1
// Size: 0x28
function ref_131a1( var0 )
{
    if ( istrue( var0 ) )
    {
        self.game_extrainfo |= 256;
        return;
    }
    
    self.game_extrainfo &= ~256;
}

// Params 1
// Size: 0x2d
function ref_131aa( var0 )
{
    if ( isdefined( self.jailed ) && self.jailed == var0 )
    {
        return;
    }
    
    ref_131a2( var0 );
    self.jailed = var0;
    level notify( "update_circle_hide" );
}

// Params 1
// Size: 0x25
function ref_131a2( var0 )
{
    if ( var0 )
    {
        self.game_extrainfo |= 128;
        return;
    }
    
    self.game_extrainfo &= ~128;
}

// Params 1
// Size: 0x52
function ref_1319f( var0 )
{
    if ( var0.set_relic_oneclip > 7 )
    {
        return;
    }
    
    var1 = 3;
    var2 = 3;
    var3 = int( pow( 2, var1 ) ) - 1;
    var4 = ( var0.set_relic_oneclip & var3 ) << var2;
    var5 = ~( var3 << var2 );
    var6 = self.game_extrainfo;
    var7 = var6 & var5;
    var8 = var7 + var4;
    self.game_extrainfo = var8;
}

// Params 2
// Size: 0x40
function startbetting( var0, var1 )
{
    if ( !level.gulag.betting )
    {
        return undefined;
    }
    
    var2 = spawnstruct();
    var2.fighters = var1;
    var2.bets = [];
    var2.bettingopen = 1;
    thread show_betting_to_players( var2 );
    return var2;
}

// Params 1
// Size: 0x6f
function show_betting_to_players( var0 )
{
    self endon( "end_betting" );
    
    for ( ;; )
    {
        var1 = getbettingplayers( var0, self );
        
        foreach ( var3 in var1 )
        {
            if ( isbot( var3 ) )
            {
                continue;
            }
            
            if ( isdefined( self.bets[ var3.guid ] ) )
            {
                continue;
            }
            
            thread showbettinghud( var0, var3 );
        }
        
        var0 waittill( "player_added_to_jail" );
    }
}

// Params 2
// Size: 0x570
function showbettinghud( var0, var1 )
{
    self endon( "end_betting" );
    var2 = spawnstruct();
    var2.owner = var1;
    self.bets[ var1.guid ] = var2;
    var2.ref_125f9 = 0;
    var2.ref_12652 = 1;
    var3 = 0;
    var4 = 50;
    var2.hudavailable = var1 scripts\mp\hud_util::createfontstring( "default", 1.2 );
    var2.hudavailable scripts\mp\hud_util::setpoint( "TOP", "TOP", var3, var4 );
    var2.hudavailable.label = &"MP_GULAG_BETTING/AVAILABLE";
    var2.hudavailable scripts\mp\hud::fontpulseinit();
    var2.spawn_truck_techo = var1 scripts\mp\hud_util::createfontstring( "default", 1.2 );
    var2.spawn_truck_techo scripts\mp\hud_util::setpoint( "TOP", "TOP", var3, var4 - 15 );
    var2.spawn_truck_techo.label = &"MP_GULAG_BETTING/BET_CLEAR";
    var2.spawn_truck_techo.alpha = 0;
    var5 = -90;
    var6 = 65;
    var2.spawn_trap_room_ent = var1 scripts\mp\hud_util::createfontstring( "default", 1.2 );
    var2.spawn_trap_room_ent scripts\mp\hud_util::setpoint( "TOP", "TOP", var5, var6 );
    var2.spawn_trap_room_ent.label = &"MP_GULAG_BETTING/BET_INCREASE_LEFT";
    var2.spawn_trap_room_ent.alpha = 1;
    var2.spawnboardroom_miniguns = var1 scripts\mp\hud_util::createfontstring( "default", 1.25 );
    var2.spawnboardroom_miniguns scripts\mp\hud_util::setpoint( "TOP", "TOP", var5 - 20, var6 + 12 );
    var2.spawnboardroom_miniguns.label = &"MP_GULAG_BETTING/ODDS_PERCENT";
    var2.spawnboardroom_miniguns setvalue( randomint( 60 ) + 20 );
    var2.spawnboardroom_miniguns.alpha = 1;
    var2.spawnboardroomblueprintweapons = var1 scripts\mp\hud_util::createfontstring( "default", 1.25 );
    var2.spawnboardroomblueprintweapons scripts\mp\hud_util::setpoint( "TOP", "TOP", var5 + 20, var6 + 12 );
    var2.spawnboardroomblueprintweapons.label = &"MP_GULAG_BETTING/ODDS_RATIO";
    var2.spawnboardroomblueprintweapons setvalue( randomint( 10 ) + 1 );
    var2.spawnboardroomblueprintweapons.alpha = 1;
    var2.spawnchoppers = var1 scripts\mp\hud_util::createfontstring( "default", 1.5 );
    var2.spawnchoppers scripts\mp\hud_util::setpoint( "TOP", "TOP", var5, var6 + 25 );
    var2.spawnchoppers.label = &"";
    
    if ( isdefined( self.fighters[ var2.ref_125f9 ] ) )
    {
        var2.spawnchoppers setplayernamestring( self.fighters[ var2.ref_125f9 ] );
    }
    
    var2.spawnchoppers.alpha = 1;
    var2.spawn_techo_lmgs = var1 scripts\mp\hud_util::createfontstring( "default", 1.5 );
    var2.spawn_techo_lmgs scripts\mp\hud_util::setpoint( "TOP", "TOP", var5, var6 + 40 );
    var2.spawn_techo_lmgs.label = &"MP_GULAG_BETTING/CURRENT_BET";
    var2.spawn_techo_lmgs.alpha = 0;
    var2.spawn_techo_lmgs scripts\mp\hud::fontpulseinit();
    var7 = 90;
    var8 = 65;
    var2.spawn_truck_group_on_proximity = var1 scripts\mp\hud_util::createfontstring( "default", 1.2 );
    var2.spawn_truck_group_on_proximity scripts\mp\hud_util::setpoint( "TOP", "TOP", var7, var8 );
    var2.spawn_truck_group_on_proximity.label = &"MP_GULAG_BETTING/BET_INCREASE_RIGHT";
    var2.spawn_truck_group_on_proximity.alpha = 1;
    var2.spawnboardroom_specialist = var1 scripts\mp\hud_util::createfontstring( "default", 1.25 );
    var2.spawnboardroom_specialist scripts\mp\hud_util::setpoint( "TOP", "TOP", var7 - 20, var8 + 12 );
    var2.spawnboardroom_specialist.label = &"MP_GULAG_BETTING/ODDS_PERCENT";
    var2.spawnboardroom_specialist setvalue( randomint( 60 ) + 20 );
    var2.spawnboardroom_specialist.alpha = 1;
    var2.spawnbunkerloot = var1 scripts\mp\hud_util::createfontstring( "default", 1.25 );
    var2.spawnbunkerloot scripts\mp\hud_util::setpoint( "TOP", "TOP", var7 + 20, var8 + 12 );
    var2.spawnbunkerloot.label = &"MP_GULAG_BETTING/ODDS_RATIO";
    var2.spawnbunkerloot setvalue( randomint( 10 ) + 1 );
    var2.spawnbunkerloot.alpha = 1;
    var2.spawnclientdevtest = var1 scripts\mp\hud_util::createfontstring( "default", 1.5 );
    var2.spawnclientdevtest scripts\mp\hud_util::setpoint( "TOP", "TOP", var7, var8 + 25 );
    var2.spawnclientdevtest.label = &"";
    
    if ( isdefined( self.fighters[ var2.ref_12652 ] ) )
    {
        var2.spawnclientdevtest setplayernamestring( self.fighters[ var2.ref_12652 ] );
    }
    
    var2.spawnclientdevtest.alpha = 1;
    var2.spawn_techo_turret = var1 scripts\mp\hud_util::createfontstring( "default", 1.5 );
    var2.spawn_techo_turret scripts\mp\hud_util::setpoint( "TOP", "TOP", var7, var8 + 40 );
    var2.spawn_techo_turret.label = &"MP_GULAG_BETTING/CURRENT_BET";
    var2.spawn_techo_turret.alpha = 0;
    var2.spawn_techo_turret scripts\mp\hud::fontpulseinit();
    var2.playerbeton = -1;
    var2.amount = 0;
    updatebethud( var2 );
    thread watchbetplaced( var2 );
    thread watchbetclear( var2 );
}

// Params 1
// Size: 0x7e
function watchbetclear( var0 )
{
    self endon( "end_betting" );
    var0.owner endon( "disconnect" );
    var1 = "betClear";
    thread notifyonplayercommandbetting( var0.owner, var1, "+special" );
    thread notifyonplayercommandbetting( var0.owner, var1, "+usereload" );
    
    for ( ;; )
    {
        var0.owner waittill( var1 );
        
        if ( var0.playerbeton == -1 )
        {
            continue;
        }
        
        var0.playerbeton = -1;
        var0.amount = 0;
        updatebethud( var0 );
    }
}

// Params 1
// Size: 0xf5
function watchbetplaced( var0 )
{
    self endon( "end_betting" );
    var0.owner endon( "disconnect" );
    var1 = "betPlacedLeft";
    var2 = "betPlacedRight";
    thread notifyonplayercommandbetting( var0.owner, var1, "+smoke" );
    thread notifyonplayercommandbetting( var0.owner, var2, "+reload" );
    thread notifyonplayercommandbetting( var0.owner, var2, "+frag" );
    
    for ( ;; )
    {
        var3 = var0.owner scripts\engine\utility::ref_143ad( var1, var2 );
        var4 = -1;
        
        if ( var3 == var1 )
        {
            var4 = var0.ref_125f9;
        }
        else if ( var3 == var2 )
        {
            var4 = var0.ref_12652;
        }
        
        if ( var0.playerbeton == var4 )
        {
            var5 = var0.amount + 1;
        }
        else
        {
            var5 = 1;
        }
        
        if ( var5 > var0.owner.plundercount )
        {
            betchangefail( var0 );
            continue;
        }
        
        var0.amount = var5;
        var0.playerbeton = var4;
        updatebethud( var0 );
    }
}

// Params 3
// Size: 0x22
function notifyonplayercommandbetting( var0, var1, var2 )
{
    var0 notifyonplayercommand( var1, var2 );
    self waittill( "end_betting" );
    
    if ( isdefined( var0 ) )
    {
        var0 notifyonplayercommandremove( var1, var2 );
        return;
    }
}

// Params 1
// Size: 0x28
function betchangefail( var0 )
{
    var0.owner playlocalsound( "br_pickup_deny" );
    var0.hudavailable thread scripts\mp\hud::fontpulse( var0.owner );
}

// Params 1
// Size: 0x1bd
function updatebethud( var0 )
{
    var1 = 100;
    var0.hudavailable setvalue( ( var0.owner.plundercount - var0.amount ) * var1 );
    
    if ( var0.playerbeton == -1 )
    {
        var0.spawn_trap_room_ent.label = &"MP_GULAG_BETTING/BET_CHANGE_LEFT";
        var0.spawn_truck_group_on_proximity.label = &"MP_GULAG_BETTING/BET_CHANGE_RIGHT";
        var0.spawn_truck_techo.alpha = 0;
        var0.spawn_techo_lmgs setvalue( 0 );
        var0.spawn_techo_turret setvalue( 0 );
        var0.spawn_techo_lmgs.alpha = 0;
        var0.spawn_techo_turret.alpha = 0;
        return;
    }
    
    if ( var0.playerbeton == var0.ref_125f9 )
    {
        var0.spawn_trap_room_ent.label = &"MP_GULAG_BETTING/BET_INCREASE_LEFT";
        var0.spawn_truck_group_on_proximity.label = &"MP_GULAG_BETTING/BET_CHANGE_RIGHT";
        var0.spawn_truck_techo.alpha = 1;
        var0.spawn_techo_lmgs setvalue( var0.amount * var1 );
        var0.spawn_techo_lmgs.alpha = 1;
        var0.spawn_techo_turret.alpha = 0;
        return;
    }
    
    if ( var0.playerbeton == var0.ref_12652 )
    {
        var0.spawn_trap_room_ent.label = &"MP_GULAG_BETTING/BET_CHANGE_LEFT";
        var0.spawn_truck_group_on_proximity.label = &"MP_GULAG_BETTING/BET_INCREASE_RIGHT";
        var0.spawn_truck_techo.alpha = 1;
        var0.spawn_techo_turret setvalue( var0.amount * var1 );
        var0.spawn_techo_turret.alpha = 1;
        var0.spawn_techo_lmgs.alpha = 0;
        return;
    }
}

// Params 2
// Size: 0xa9
function cleanupbethud( var0, var1 )
{
    var0 notify( "cleanUpBetHud" );
    
    if ( isdefined( var1 ) )
    {
        var0 endon( "cleanUpBetHud" );
        wait var1;
    }
    
    var2 = [ var0.spawn_trap_room_ent, var0.spawn_truck_group_on_proximity, var0.spawn_techo_lmgs, var0.spawn_techo_turret, var0.spawnchoppers, var0.spawnclientdevtest, var0.spawnboardroom_miniguns, var0.spawnboardroomblueprintweapons, var0.spawnboardroom_specialist, var0.spawnbunkerloot, var0.hudavailable, var0.spawn_truck_techo ];
    
    foreach ( var4 in var2 )
    {
        if ( isdefined( var4 ) )
        {
            var4 destroy();
        }
    }
}

// Params 4
// Size: 0x1e
function watchbetbutton( var0, var1, var2, var3 )
{
    self endon( "end_betting" );
    
    for ( ;; )
    {
        var1 waittill( var2 );
        var0 notify( "betPlaced", var3 );
    }
}

// Params 2
// Size: 0x15e
function endbetting( var0, var1 )
{
    if ( !isdefined( var1 ) || !istrue( var1.bettingopen ) )
    {
        return;
    }
    
    var1 notify( "end_betting" );
    var1.bettingopen = 0;
    
    foreach ( var3 in var1.bets )
    {
        var4 = [ var3.spawn_truck_techo, var3.hudavailable, var3.spawnboardroom_specialist, var3.spawnboardroom_miniguns, var3.spawnbunkerloot, var3.spawnboardroomblueprintweapons, var3.spawn_trap_room_ent, var3.spawn_truck_group_on_proximity ];
        
        if ( var3.playerbeton != -1 )
        {
            if ( var3.playerbeton == var3.ref_125f9 )
            {
                var4 = var3.spawnclientdevtest;
                var4 = var3.spawn_truck_group_on_proximity;
                var4 = var3.spawn_techo_turret;
            }
            else if ( var3.playerbeton == var3.ref_12652 )
            {
                var4 = var3.spawnchoppers;
                var4 = var3.spawn_trap_room_ent;
                var4 = var3.spawn_techo_lmgs;
            }
        }
        else
        {
            cleanupbethud( var3, 0 );
        }
        
        foreach ( var6 in var4 )
        {
            if ( isdefined( var6 ) )
            {
                var6 destroy();
            }
        }
    }
    
    updateoutlines( var0 );
}

// Params 2
// Size: 0x89
function payoutremainingbets( var0, var1 )
{
    if ( !isdefined( var1 ) )
    {
        return;
    }
    
    var2 = -1;
    
    if ( isdefined( var0 ) )
    {
        var2 = var0.fighterindex;
    }
    
    foreach ( var4 in var1.bets )
    {
        if ( var4.playerbeton != -1 && isdefined( var4.owner ) && !istrue( var4.paidout ) )
        {
            var5 = var4.playerbeton == var2;
            _completebet( var1, var4, var5 );
        }
        
        thread cleanupbethud( var4, 2.5 );
    }
}

// Params 3
// Size: 0x28b
function _completebet( var0, var1, var2 )
{
    var3 = ( 0, 1, 0 );
    var4 = ( 1, 0, 0 );
    var1.paidout = 1;
    
    if ( var2 )
    {
        var1.owner scripts\mp\gametypes\br_plunder::playersetplundercount( var1.owner.plundercount + var1.amount );
        
        if ( var1.playerbeton == var1.ref_125f9 )
        {
            var1.spawnchoppers.color = var3;
            var1.spawnchoppers.label = &"MP_GULAG_BETTING/FIGHER_WINNER";
            var1.spawn_techo_lmgs.color = var3;
            var1.spawn_techo_lmgs.label = &"MP_GULAG_BETTING/AMOUNT_WON";
            var1.owner playlocalsound( "ammo_crate_use" );
            var1.spawn_techo_lmgs thread scripts\mp\hud::fontpulse( var1.owner );
        }
        else if ( var1.playerbeton == var1.ref_12652 )
        {
            var1.spawnclientdevtest.color = var3;
            var1.spawnclientdevtest.label = &"MP_GULAG_BETTING/FIGHER_WINNER";
            var1.spawn_techo_turret.color = var3;
            var1.spawn_techo_turret.label = &"MP_GULAG_BETTING/AMOUNT_WON";
            var1.owner playlocalsound( "ammo_crate_use" );
            var1.spawn_techo_turret thread scripts\mp\hud::fontpulse( var1.owner );
        }
    }
    else
    {
        if ( isalive( var1.owner ) )
        {
            var5 = var1.owner.plundercount - var1.amount;
            var5 = int( max( 0, var5 ) );
            var1.owner scripts\mp\gametypes\br_plunder::playersetplundercount( var5 );
        }
        
        if ( var1.playerbeton == var1.ref_125f9 )
        {
            var1.spawnchoppers.color = var4;
            var1.spawnchoppers.label = &"MP_GULAG_BETTING/FIGHER_LOSER";
            var1.spawn_techo_lmgs.color = var4;
            var1.spawn_techo_lmgs.label = &"MP_GULAG_BETTING/AMOUNT_LOST";
            var1.spawn_techo_lmgs thread scripts\mp\hud::fontpulse( var1.owner );
        }
        else if ( var1.playerbeton == var1.ref_12652 )
        {
            var1.spawnclientdevtest.color = var4;
            var1.spawnclientdevtest.label = &"MP_GULAG_BETTING/FIGHER_LOSER";
            var1.spawn_techo_turret.color = var4;
            var1.spawn_techo_turret.label = &"MP_GULAG_BETTING/AMOUNT_LOST";
            var1.spawn_techo_turret thread scripts\mp\hud::fontpulse( var1.owner );
        }
    }
    
    var6 = var0.fighters[ var1.playerbeton ];
    
    if ( isdefined( var6 ) )
    {
        var6 hudoutlinedisableforclient( var1.owner );
        return;
    }
}

// Params 2
// Size: 0x50
function getbettingplayers( var0, var1 )
{
    var2 = var0.jailedplayers;
    
    if ( level.gulag.betting > 1 )
    {
        foreach ( var4 in var1.fighters )
        {
            var2 = var4;
        }
    }
    
    return var2;
}

// Params 3
// Size: 0x71
function payoutbet( var0, var1, var2 )
{
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    foreach ( var4 in var0.bets )
    {
        if ( var4.playerbeton == var1.fighterindex && isdefined( var4.owner ) && !istrue( var4.paidout ) )
        {
            _completebet( var0, var4, var2 );
            thread cleanupbethud( var4, 2.5 );
        }
    }
}

// Params 1
// Size: 0x46
function rock_used( var0 )
{
    var1 = self.arena;
    var0 scripts\engine\utility::waittill_notify_or_timeout( "missile_stuck", 4 );
    wait 2;
    
    if ( isdefined( var0 ) )
    {
        var0 delete();
    }
    
    if ( istrue( level.usegulag ) && level.gulag.ref_1407f )
    {
        spawnrock( var1 );
        return;
    }
}

// Params 1
// Size: 0xf5
function spawnrocks( var0 )
{
    var0.rocks = getentitylessscriptablearrayinradius( var0.target, "targetname" );
    
    if ( var0.rocks.size == 0 || !level.gulag.ref_1407f )
    {
        for ( var1 = 0; var1 < var0.rocks.size ; var1++ )
        {
            var2 = var0.rocks[ var1 ];
            var2 setscriptablepartstate( "brloot_rock", "hidden" );
        }
        
        return;
    }
    
    var3 = 20;
    
    if ( var2.rocks.size < var3 )
    {
        var3 = var2.rocks.size;
    }
    
    var2.rocks = scripts\engine\utility::array_randomize( var2.rocks );
    var2.rockcounter = var3;
    var4 = getdvarint( "scr_br_fc_rocks", 1 ) == 0;
    
    for ( var1 = 0; var1 < var2.rocks.size ; var1++ )
    {
        var2 = var2.rocks[ var1 ];
        var2.arena = var2;
        
        if ( var1 >= var3 || var4 )
        {
            var2 setscriptablepartstate( "brloot_rock", "hidden" );
        }
    }
}

// Params 5
// Size: 0x63
function rockused( var0, var1, var2, var3, var4 )
{
    if ( !isdefined( var0 ) || !isdefined( var3 ) )
    {
        return;
    }
    
    var5 = getcompleteweaponname( "rock_mp" );
    
    if ( var3 hasweapon( var5 ) && var3 getammocount( var5 ) > 0 )
    {
        return;
    }
    
    var0 setscriptablepartstate( "brloot_rock", "hidden" );
    var3 thread scripts\mp\gametypes\br_pickups::playerplaypickupanim();
    var3 scripts\mp\equipment::giveequipment( "equip_rock", "primary" );
    var3 playlocalsound( "br_rock_pickup" );
}

// Params 1
// Size: 0x63
function spawnrock( var0 )
{
    if ( istrue( var0.shutdown ) || var0.rocks.size == 0 )
    {
        return;
    }
    
    var1 = var0.rocks[ var0.rockcounter ];
    var1 setscriptablepartstate( "brloot_rock", "visible" );
    var0.rockcounter++;
    
    if ( var0.rockcounter >= var0.rocks.size )
    {
        var0.rockcounter = 0;
        return;
    }
}

// Params 1
// Size: 0x38
function playertakeawayrock( var0 )
{
    var1 = getcompleteweaponname( "rock_mp" );
    
    if ( self hasweapon( var1 ) )
    {
        self takeweapon( var1 );
        self clearaccessory();
        
        if ( level.gulag.ref_1407f )
        {
            spawnrock( var0 );
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x154
function ref_126f3( var0 )
{
    var1 = self;
    
    if ( !isdefined( level.pickup_truck_initdamage ) )
    {
        return;
    }
    
    if ( isdefined( level.br_circle.circleindex ) )
    {
        var2 = level.br_circle.circleindex + 1;
        
        if ( var2 > level.phase_five_combat )
        {
            return;
        }
    }
    
    var3 = 0;
    
    if ( isdefined( level.vehicle.instances[ "veh_a10fd" ] ) )
    {
        var3 += level.vehicle.instances[ "veh_a10fd" ].size;
    }
    
    if ( isdefined( level.vehicle.instances[ "veh_bt" ] ) )
    {
        var3 += level.vehicle.instances[ "veh_bt" ].size;
    }
    
    if ( var3 >= level.pickup_truck_initdamage )
    {
        return;
    }
    
    if ( istrue( var1.ref_145bf ) )
    {
        return;
    }
    
    var4 = "undefined";
    
    if ( isdefined( var1.currentweapon ) )
    {
        var4 = var1.currentweapon.basename;
    }
    
    var5 = "undefined";
    
    if ( isdefined( var1.name ) )
    {
        var5 = var1.name;
    }
    
    if ( level.ph_setfinalkillcamwinner > 0 && randomfloat( 1 ) < level.ph_setfinalkillcamwinner )
    {
        logstring( "[FD] Respawning in fd: success - token used: " + var0 + ", for player: " + var5 + " with weapon: " + var4 );
        var1.ref_12c9e = var0;
        var1.ref_145bf = 1;
        return;
    }
    
    logstring( "[FD] Respawning in fd: fail - token used: undefined, for player: " + var5 + " with weapon: " + var4 );
    var1.ref_12c9e = undefined;
    var1.ref_145bf = undefined;
}

// Params 0
// Size: 0x161
function ref_1268c()
{
    thread gulagfadefromblack( 3 );
    
    if ( isdefined( level.pilot_tag ) )
    {
        var0 = [[ level.pilot_tag ]]();
    }
    else
    {
        var0 = scripts\mp\gametypes\br_circle::risk_modifyflagstieronrespawn( 0.9, 0.95 );
    }
    
    var1 = level.br_circle.circleindex + 1;
    
    if ( !isdefined( level.br_level.default_class_chosen[ var1 ] ) )
    {
        var1 = level.br_circle.circleindex;
    }
    
    var2 = vectortoyaw( level.br_level.default_class_chosen[ var1 ] - var0 );
    var3 = spawnstruct();
    var3.origin = ( var0[ 0 ], var0[ 1 ], 11500 );
    var3.angles = ( 0, var2, 0 );
    var3.cannotbesuspended = 1;
    var4 = spawnstruct();
    
    if ( isdefined( self.ref_12c9f ) )
    {
        var5 = self.ref_12c9f;
    }
    else
    {
        var5 = "veh_a10fd";
        
        if ( randomfloat( 1 ) > level.ph_endgame )
        {
            var5 = "veh_bt";
        }
    }
    
    var4.targetname = var5;
    
    switch ( var5 )
    {
        case "veh_bt":
            var4.modelname = "veh_s4_mil_air_bomber_wz";
            var4.vehicletype = "bt_mp";
            var6 = _calloutmarkerping_handleluinotify_mappingdeletemarker::create_mp_version_of_vehicle( var4, var5 );
            break;
        case "veh_a10fd":
            var5.modelname = "veh_s4_mil_air_dalpha_wz";
            var5.vehicletype = "a10_warthog_fd";
            var6 = _calloutmarkerping_isvehicleoccupiedbyenemy::bot_gametype_set_role( var5, var5 );
            break;
        default:
            return;
    }
    
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter( var6, "pilot", self );
}

// Params 3
// Size: 0xbb
function gettangentoncirclefrompoint( var0, var1, var2 )
{
    var3 = var2[ 0 ] - var0[ 0 ];
    var4 = var2[ 1 ] - var0[ 1 ];
    var5 = var1;
    var6 = var3 * var3;
    var7 = var4 * var4;
    var8 = var5 * var5;
    var9 = var6 + var7 - var8;
    var10 = undefined;
    var11 = 1;
    
    if ( var9 > 0 )
    {
        var12 = ( var8 * var3 - var5 * var4 * sqrt( var6 + var7 - var8 ) ) / ( var6 + var7 );
        var13 = ( var8 * var4 + var5 * var3 * sqrt( var6 + var7 - var8 ) ) / ( var6 + var7 );
        var10 = ( var12, var13, var2[ 2 ] ) + ( var0[ 0 ], var0[ 1 ], 0 );
    }
    else
    {
        var14 = vectornormalize( ( var3, var4, 0 ) );
        var15 = var0 + var14 * var1;
        var10 = ( var15[ 0 ], var15[ 1 ], var2[ 2 ] );
        var11 = 0;
    }
    
    return [ var10, var11 ];
}

// Params 0
// Size: 0x1ef
function spawnac130()
{
    if ( !istrue( level.gulag.planerespawn ) )
    {
        return;
    }
    
    level waittill( "prematch_started" );
    
    if ( !istrue( level.br_infils_disabled ) )
    {
        wait 10;
    }
    
    var0 = undefined;
    var1 = undefined;
    
    if ( isdefined( level.br_ac130 ) )
    {
        var0 = level.br_ac130.startpt;
    }
    else
    {
        var2 = scripts\mp\gametypes\br_c130::createtestc130path();
        var0 = var2.startpt;
    }
    
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.safecircleent ) )
    {
        var1 = level.br_circle.safecircleent.origin[ 2 ];
    }
    else
    {
        var1 = level.br_level.br_circleradii[ 0 ];
    }
    
    var1 -= 100;
    var3 = gettangentoncirclefrompoint( level.br_level.br_mapcenter, var1, var0 );
    var4 = var3[ 0 ];
    var5 = var3[ 1 ];
    var3 = undefined;
    var6 = 0;
    var7 = 0;
    
    if ( var5 )
    {
        var6 = distance( var0, var4 );
        var7 = var6 / scripts\mp\gametypes\br_c130::getc130speed();
    }
    
    var8 = ( level.br_level.br_mapcenter[ 0 ], level.br_level.br_mapcenter[ 1 ], var0[ 2 ] );
    level.gulag.ac130linker = spawn( "script_model", var8 );
    level.gulag.ac130linker setmodel( "tag_origin" );
    level.gulag.ac130linker.radius = var1;
    level.gulag.ac130 = scripts\mp\gametypes\br_c130::gunship_spawn( var0, var4, var7, 0, &ac130handlemovement );
    thread ac130setupanim();
    level.gulag.ac130.riders = [];
    
    if ( var7 <= 0 )
    {
        var9 = var4 - level.br_level.br_mapcenter;
        var10 = vectornormalize( ( var9[ 0 ], var9[ 1 ], 0 ) );
        var11 = vectortoangles( var10 );
        level.gulag.ac130 unlink();
        level.gulag.ac130.angles = ( 0, var11[ 1 ] + 90, 0 );
        level.gulag.ac130.origin = var4;
        thread ac130linkandspin();
        return;
    }
}

// Params 0
// Size: 0x31
function ac130setupanim()
{
    var0 = spawnstruct();
    self.animstruct = var0;
    var0.movingc130 = self;
    scripts\mp\gametypes\br_infils::spawnplayerpositionparentent( var0, self );
    scripts\mp\gametypes\br_infils::spawnplayerpositionent( var0, "j_prop_1" );
    scripts\mp\gametypes\br_infils::playac130infilloopanims( var0 );
}

// Params 2
// Size: 0x34
function ac130handlemovement( var0, var1 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self playloopsound( "br_ac130_lp" );
    
    if ( var1 > 0 )
    {
        self moveto( var0, var1, 0, 0 );
        wait var1;
    }
    
    thread ac130linkandspin();
}

// Params 0
// Size: 0x7d
function ac130linkandspin()
{
    self notify( "ac130LinkAndSpin" );
    self endon( "ac130LinkAndSpin" );
    level.gulag.ac130linker endon( "death" );
    var0 = 6.28318;
    var1 = scripts\mp\gametypes\br_c130::getc130speed();
    var2 = level.gulag.ac130linker.radius;
    var3 = var0 * var2 / var1;
    self linkto( level.gulag.ac130linker, "tag_origin" );
    
    if ( var3 <= 0 )
    {
        return;
    }
    
    for ( ;; )
    {
        level.gulag.ac130linker rotateyaw( 360, var3 );
        wait var3;
    }
}

// Params 0
// Size: 0x66
function waittillallarenasshutdown()
{
    var0 = level.gulag.arenas.size;
    jumpiftrue(istrue( level.gulag.multiarena )) LOC_00000021;
    var0 = 1;
    
    for ( ;; )
    {
        var1 = 0;
        
        for ( var2 = 0; var2 < var0 ; var2++ )
        {
            var3 = level.gulag.arenas[ var2 ];
            
            if ( !istrue( var3.shutdown ) )
            {
                var1 = 1;
                break;
            }
        }
        
        if ( !var1 )
        {
            return;
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0x177
function makeac130flyaway()
{
    if ( !istrue( level.gulag.planerespawn ) )
    {
        return;
    }
    
    var0 = gettime();
    waittillallarenasshutdown();
    var1 = gettime();
    wait getdvarint( "scr_br_fc_respawn_wait", 15 );
    waittillframeend();
    
    foreach ( var3 in level.gulag.ac130.riders )
    {
        if ( isdefined( var3 ) )
        {
            var3.jumptype = "solo";
            var3 notify( "halo_kick_c130" );
        }
    }
    
    while ( level.gulag.ac130.riders.size > 0 )
    {
        waitframe();
    }
    
    var5 = level.gulag.ac130.origin;
    var6 = anglestoforward( level.gulag.ac130.angles );
    var7 = level.br_level.br_circleradii[ 0 ] * 2;
    var8 = var5 + var6 * var7;
    var8 += var6 * scripts\mp\gametypes\br_c130::getc130speed();
    var9 = distance( var5, var8 );
    var10 = var9 / scripts\mp\gametypes\br_c130::getc130speed();
    level.gulag.ac130 notify( "ac130LinkAndSpin" );
    level.gulag.ac130 unlink();
    level.gulag.ac130 moveto( var8, var10, 0, 0 );
    wait var10;
    scripts\mp\gametypes\br_public::cleanac130struct( level.gulag.ac130.animstruct );
    
    if ( isdefined( level.gulag.ac130 ) )
    {
        level.gulag.ac130 delete();
    }
    
    if ( isdefined( level.gulag.ac130linker ) )
    {
        level.gulag.ac130linker delete();
        return;
    }
}

// Params 2
// Size: 0x139
function transitioncircle( var0, var1 )
{
    if ( !istrue( level.gulag.planerespawn ) )
    {
        return;
    }
    
    if ( !isdefined( level.gulag.ac130 ) || !isdefined( level.gulag.ac130linker ) )
    {
        return;
    }
    
    var2 = ( level.br_circle.safecircleent.origin[ 0 ], level.br_circle.safecircleent.origin[ 1 ], level.gulag.ac130linker.origin[ 2 ] );
    var0 -= 100;
    
    if ( level.gulag.ac130linker.radius != var0 )
    {
        var3 = vectornormalize( level.gulag.ac130linker.origin - level.gulag.ac130.origin );
        var4 = level.gulag.ac130.origin + var3 * var0;
        level.gulag.ac130 unlink();
        level.gulag.ac130linker.origin = var4;
        level.gulag.ac130linker.radius = var0;
        level.gulag.ac130linker dontinterpolate();
        thread ac130linkandspin();
    }
    
    level.gulag.ac130linker moveto( var2, var1 );
    wait var1;
}

// Params 0
// Size: 0x8e
function playersetupac130()
{
    self.infilanimindex = 1;
    self.isjumpmaster = 0;
    scripts\mp\gametypes\br_infils::playerlinktopositionent( level.gulag.ac130.animstruct );
    thread scripts\mp\gametypes\br_infils::playerplayinfilloopanim( level.gulag.ac130.animstruct );
    thread playerputinc130( level.gulag.ac130 );
    scripts\mp\gametypes\br_infils::playersetupcontrolsforinfil( 1 );
    thread playerac130cleanup();
    thread playerautodeployaftertime();
    thread playerspawnprotectionac130();
    level.gulag.ac130.riders[ level.gulag.ac130.riders.size ] = self;
}

// Params 1
// Size: 0x39
function playerputinc130( var0 )
{
    self.angles = var0.angles;
    thread listenjump( var0 );
    thread scripts\mp\gametypes\br_c130::listenkick( var0, 0 );
    scripts\mp\utility\game::ref_131a3( self, 1 );
    self.br_infil_type = "c130";
    thread scripts\mp\gametypes\br_public::orbitcam( var0 );
}

// Params 1
// Size: 0x4d
function listenjump( var0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "cancel_c130" );
    self endon( "br_jump" );
    self.redeployenabled = 0;
    scripts\engine\utility::waittill_either( "halo_jump_c130", "halo_jump_solo_c130" );
    self.jumptype = "solo";
    thread scripts\mp\gametypes\br_c130::leaveplane( var0, 0, self getplayerangles(), 0 );
}

// Params 0
// Size: 0x2c
function playerspawnprotectionac130()
{
    self endon( "death_or_disconnect" );
    self.plotarmor = 1;
    scripts\mp\gametypes\br_c130::setplayervarinrespawnc130( 1 );
    waittillplayerdoneskydivingac130( self );
    self.plotarmor = undefined;
    scripts\mp\gametypes\br_c130::setplayervarinrespawnc130( 0 );
}

// Params 1
// Size: 0x2e
function waittillplayerdoneskydivingac130( var0 )
{
    var0 endon( "timeout_gulag_ac130" );
    thread _waittillplayerdoneskydivingac130timeout( var0 );
    var0 waittill( "infil_jump_done" );
    
    while ( !var0 isparachuting() && !var0 isonground() )
    {
        waitframe();
    }
}

// Params 1
// Size: 0x31
function _waittillplayerdoneskydivingac130timeout( var0 )
{
    var0 endon( "death_or_disconnect" );
    var0 scripts\engine\utility::ref_143ba( getdvarint( "scr_br_fc_respawn_wait", 15 ), "halo_kick_c130", "halo_jump_solo_c130" );
    wait 15;
    var0 notify( "timeout_gulag_ac130" );
}

// Params 0
// Size: 0x42
function playerautodeployaftertime()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "cancel_c130" );
    self endon( "br_jump" );
    wait getdvarint( "scr_br_fc_respawn_wait", 15 );
    self.jumptype = "solo";
    self notify( "halo_kick_c130" );
}

// Params 0
// Size: 0x91
function playerac130cleanup()
{
    level endon( "game_ended" );
    scripts\engine\utility::ref_143a7( "disconnect", "death", "cancel_c130", "infil_jump_done" );
    
    if ( !isdefined( level.gulag.ac130.riders ) )
    {
        return;
    }
    
    if ( isdefined( self ) )
    {
        level.gulag.ac130.riders = scripts\engine\utility::array_remove( level.gulag.ac130.riders, self );
        return;
    }
    
    level.gulag.ac130.riders = scripts\engine\utility::array_removeundefined( level.gulag.ac130.riders );
}

// Params 5
// Size: 0x142
function playergulagautowin( var0, var1, var2, var3, var4 )
{
    var5 = self;
    level endon( "game_ended" );
    var5 endon( "disconnect" );
    var5 notify( "gulag_auto_win" );
    
    if ( istrue( var5.respawningfromtoken ) )
    {
        return;
    }
    
    var6 = ref_125c7( var5, var1, var2, var4, undefined, var0 );
    var7 = var6[ 0 ];
    var8 = var6[ 1 ];
    var6 = undefined;
    var5.respawningfromtoken = 1;
    var9 = ref_126e8( var5 );
    var10 = scripts\mp\gametypes\br_public::relic_nuketimer_gettimeformission() / 1000;
    var11 = ref_125be( var5, 0, var10 );
    var12 = ref_1263e( var5, var11 );
    self.forcespawnorigin = var12;
    var13 = scripts\mp\gametypes\br_gametypes::ref_12e05( "playerGulagAutoWinWait", var1, var2 );
    
    if ( !istrue( var13 ) )
    {
        var14 = 1;
        wait var14;
    }
    
    if ( var9 )
    {
        var5 scripts\mp\utility\lower_message::setlowermessageomnvar( 0 );
    }
    
    var15 = 1;
    gulagfadetoblack( var5, 1 );
    wait var15;
    var5 scripts\mp\hud_message::heartbeat_sensor_pick_up_monitor();
    var5 scripts\mp\playerlogic::spawnplayer( undefined, 0 );
    var5 scripts\cp_mp\execution::_clearexecution();
    var5 scripts\mp\gametypes\br_pickups::initplayer();
    var5 scripts\mp\gametypes\br_spectate::ref_1252a();
    var5.respawningfromtoken = undefined;
    
    if ( !isdefined( var1 ) && !istrue( var3 ) )
    {
        thread ref_13dcb( var5 );
    }
    
    var5.plotarmor = undefined;
    var5.c130 = undefined;
    
    if ( !isdefined( var5.ref_145bf ) )
    {
        ref_126f3( var5, var2 );
    }
    
    gulagwinnerrespawn( var5, 1, var8, var11, 1, var12, undefined, var7, var4, undefined, undefined, var2 );
}

// Params 5
// Size: 0xb1
function ref_125c7( var0, var1, var2, var3, var4 )
{
    var5 = self;
    var6 = var5;
    var7 = "token";
    
    if ( isdefined( var0 ) )
    {
        var8 = istrue( var5.delay_enter_combat_after_investigating_grenade ) && !isalive( var5 ) && istrue( var5.ref_14439 );
        var6 = var0;
        var7 = "token_sponsored";
        
        if ( !istrue( var3 ) )
        {
            if ( istrue( var1 ) )
            {
                var9 = 6;
            }
            else
            {
                var9 = 10;
            }
            
            thread ref_13dcb( var6 );
        }
    }
    
    if ( isdefined( var1 ) || istrue( var3 ) )
    {
        var6 scripts\mp\playerlogic::addtoalivecount( var5 );
        scripts\mp\gametypes\br::ref_13f21( var6, var5 );
    }
    
    scripts\mp\gametypes\br_analytics::destroyawardlaunchonly( var6, var8 );
    scripts\mp\gametypes\br_analytics::devspectatetesthost( self, int( isdefined( var1 ) ) );
    
    if ( istrue( var7.hasrespawntoken ) )
    {
        var7 scripts\mp\gametypes\br_pickups::removerespawntoken();
    }
    
    return [ var7, var8 ];
}

// Params 0
// Size: 0x2d
function ref_126e8()
{
    var0 = self;
    var1 = istrue( var0.ref_12876 );
    
    if ( var1 )
    {
        var0 scripts\mp\utility\lower_message::setlowermessageomnvar( 76 );
        
        while ( istrue( var0.ref_12876 ) )
        {
            waitframe();
        }
    }
    
    return var1;
}

// Params 0
// Size: 0x17
function gulaginitloadouts()
{
    level.gulag.vehicle_compass_deregisterinstance = init_relic_punchbullets();
    init_relic_rocket_kill_ammo();
}

// Params 0
// Size: 0x111
function init_relic_punchbullets()
{
    var0 = [];
    GscBinSkip0( 0x2e, "loadoutArchetype", "archetype_assault" );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 0
// Size: 0xb3
function init_relic_rocket_kill_ammo()
{
    level.set_relic_thirdperson = [];
    level.set_relic_trex = give_and_switch_to_secondary_weapon();
    
    if ( getdvar( "scr_br_gulag_loadout_override" ) != "" )
    {
        var0 = strtok( getdvar( "scr_br_gulag_loadout_override" ), " " );
        var1 = [];
        
        for ( var2 = 0; var2 < var0.size ; var2++ )
        {
            var1 = int( var0[ var1.size ] );
        }
        
        var3 = var1.size;
        
        for ( var4 = 0; var4 < var3 ; var4++ )
        {
            level.set_relic_thirdperson[ level.set_relic_thirdperson.size ] = init_relic_oneclip( var1[ var4 ] );
        }
        
        return;
    }
    
    var3 = tablelookupgetnumcols( level.set_relic_trex ) - 1;
    
    for ( var4 = 0; var4 < var3 ; var4++ )
    {
        level.set_relic_thirdperson[ level.set_relic_thirdperson.size ] = init_relic_oneclip( var4 );
    }
}

// Params 0
// Size: 0xd4
function give_and_switch_to_secondary_weapon()
{
    var0 = getdvarint( "scr_br_gulag_table_override", 0 );
    
    if ( var0 )
    {
        if ( var0 == 444 )
        {
            if ( randomint( 2 ) == 0 )
            {
                return "mp/classtable_br_gulagdbd1.csv";
            }
            else
            {
                return "mp/classtable_br_gulagdbd2.csv";
            }
        }
        else if ( var0 == 445 )
        {
            return "mp/classtable_br_gulagtdbd1.csv";
        }
        else
        {
            return ( "mp/classtable_br_gulag" + var0 + ".csv" );
        }
    }
    
    if ( getdvarint( "scr_br_gulag_melee_override", 0 ) == 1 )
    {
        return "mp/classtable_br_gulag_melee.csv";
    }
    
    var1 = randomint( 1337 ) + 1;
    
    if ( var1 == 1337 )
    {
        return "mp/classtable_br_gulag99.csv";
    }
    
    var2 = randomint( 100 ) + 1;
    
    if ( var2 > 90 )
    {
        return "mp/classtable_br_gulag4.csv";
    }
    else if ( var2 > 65 )
    {
        return "mp/classtable_br_gulag2.csv";
    }
    else if ( var2 > 40 )
    {
        return "mp/classtable_br_gulag3.csv";
    }
    else
    {
        return "mp/classtable_br_gulag1.csv";
    }
    
    return "mp/classtable_br_gulag1.csv";
}

// Params 1
// Size: 0x2ab
function init_relic_oneclip( var0 )
{
    GscBinSkip1( 0x45, "loadoutArchetype", "archetype_assault" );
    // Unknown operator ( 0x45, iw8, PC )
}

// Params 2
// Size: 0xb4
function playergivearenaloadout( var0, var1 )
{
    if ( getdvarint( "scr_br_fc_loadouts", 1 ) == 0 )
    {
        return;
    }
    
    self.pers[ "gamemodeLoadout" ] = level.set_relic_thirdperson[ var1 ];
    gethightestpriotiryactiveburnstate( var1 );
    self.class = "gamemode";
    self.prevweaponobj = undefined;
    var2 = scripts\mp\class::loadout_getclassstruct();
    var2 = scripts\mp\class::loadout_updateclass( var2, "gamemode" );
    scripts\mp\class::preloadandqueueclassstruct( var2, 1, 1 );
    scripts\mp\class::giveloadout( self.team, "gamemode", 0, 0 );
    self givestartammo( var2.loadoutprimaryobject );
    
    if ( isdefined( var2.loadoutsecondaryobject ) )
    {
        self givestartammo( var2.loadoutsecondaryobject );
    }
    
    self.set_relic_team_proximity = level.set_relic_thirdperson[ var1 ][ "tableColumn" ];
    ref_12687( var0, "loadoutRow", self.set_relic_team_proximity );
}

// Params 1
// Size: 0x203
function gethightestpriotiryactiveburnstate( var0 )
{
    if ( getdvarint( "scr_br_alt_mode_gg", 0 ) )
    {
        switch ( var0 )
        {
            case 0:
                var1 = "iw8_pi_decho";
                break;
            case 1:
                var1 = "iw8_pi_cpapa";
                break;
            case 2:
                var1 = "iw8_pi_decho";
                break;
            case 3:
                var1 = "iw8_pi_cpapa";
                break;
            case 4:
                var1 = "iw8_pi_decho";
                break;
            case 5:
                var1 = "iw8_pi_cpapa";
                break;
            case 6:
                var1 = "iw8_pi_decho";
                break;
            case 7:
                var1 = "iw8_pi_cpapa";
                break;
            case 8:
                var1 = "iw8_pi_decho";
                break;
            case 9:
            default:
                var1 = "iw8_pi_cpapa";
                break;
        }
        
        self.pers[ "gamemodeLoadout" ][ "loadoutPrimary" ] = var1;
        self.pers[ "gamemodeLoadout" ][ "loadoutPrimaryAttachment" ] = "none";
        self.pers[ "gamemodeLoadout" ][ "loadoutPrimaryAttachment2" ] = "none";
        self.pers[ "gamemodeLoadout" ][ "loadoutPrimaryAttachment3" ] = "none";
        self.pers[ "gamemodeLoadout" ][ "loadoutPrimaryAttachment4" ] = "none";
        self.pers[ "gamemodeLoadout" ][ "loadoutPrimaryAttachment5" ] = "none";
        self.pers[ "gamemodeLoadout" ][ "loadoutSecondary" ] = "none";
        self.pers[ "gamemodeLoadout" ][ "loadoutSecondaryAttachment" ] = "none";
        self.pers[ "gamemodeLoadout" ][ "loadoutSecondaryAttachment2" ] = "none";
        self.pers[ "gamemodeLoadout" ][ "loadoutSecondaryAttachment3" ] = "none";
        self.pers[ "gamemodeLoadout" ][ "loadoutSecondaryAttachment4" ] = "none";
        self.pers[ "gamemodeLoadout" ][ "loadoutSecondaryAttachment5" ] = "none";
        self.pers[ "gamemodeLoadout" ][ "loadoutPerks" ] = [ "specialty_null" ];
        return;
    }
}

// Params 0
// Size: 0x88
function getloadoutindex()
{
    if ( getdvarint( "scr_br_fc_loadouts", 1 ) == 0 )
    {
        return;
    }
    
    var0 = getdvarint( "scr_br_fc_loadoutOverride", -1 );
    
    if ( var0 > -1 && var0 < level.set_relic_thirdperson.size )
    {
        return var0;
    }
    
    if ( getdvar( "scr_br_gulag_loadout_override" ) != "" )
    {
        if ( !isdefined( level.set_relic_team_proximity ) || level.set_relic_team_proximity >= level.set_relic_thirdperson.size )
        {
            level.set_relic_team_proximity = 0;
        }
        
        var1 = level.set_relic_team_proximity;
        level.set_relic_team_proximity += 1;
    }
    else
    {
        var1 = randomint( level.set_relic_thirdperson.size );
    }
    
    return var1;
}

// Params 1
// Size: 0xaf
function ref_1428f( var0 )
{
    var0 endon( "fight_over" );
    var0 endon( "matchEnded" );
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    var1 = level.gulag.timelimit;
    level.gulag.timelimit = 180;
    iprintln( "Loadout verification starting in 3 seconds." );
    wait 3;
    iprintln( "Verification start!" );
    
    for ( var2 = 0; var2 < level.set_relic_thirdperson.size ; var2++ )
    {
        iprintln( "Loadout: " + var2 );
        playergivearenaloadout( var0, var2 );
        wait 5;
        scripts\cp_mp\utility\inventory_utility::_switchtoweapon( self.secondaryweapon );
        wait 4;
    }
    
    playergivearenaloadout( var0, 0 );
    level.gulag.timelimit = var1;
    iprintln( "Verification done!" );
}

// Params 1
// Size: 0x124
function ref_1323a( var0 )
{
    var1 = getdvarint( "scr_br_fc_flag_radius", 50 );
    var0.managevehiclehealthui = spawnstruct();
    var2 = getgroundposition( var0.center, 1 );
    var0.managevehiclehealthui.trigger = spawn( "trigger_radius", var2, 0, int( var1 ), int( level.defend_wave_3 ) );
    var3 = scripts\mp\gametypes\obj_dom::setupobjective( var0.managevehiclehealthui.trigger, "neutral", undefined, 1 );
    var3.onuse = &arenaflag_onuse;
    var3.onbeginuse = &arenaflag_onusebegin;
    var3.onenduse = &arenaflag_onuseend;
    var3.onuseupdate = &arenaflag_onuseupdate;
    var3.oncontested = &arenaflag_oncontested;
    var3.isarena = 1;
    var3 scripts\mp\gameobjects::pinobjiconontriggertouch();
    var3.id = "domFlag";
    var3 scripts\mp\gameobjects::setcapturebehavior( "persistent" );
    var3.scriptable delete();
    var3.ignorestomp = 1;
    var3 scripts\mp\gameobjects::requestid( 0, 1, undefined, 0, 0 );
    var3.visibilitymanuallycontrolled = 1;
    calloutmarkerping_watchwhenobjectivedeleted( var3, 0 );
    calloutmarkerping_watchwhenobjectivestartsprogress( var3, var0, 0 );
    var3.arena = var0;
    var0.managevehiclehealthui.arenaflag = var3;
}

// Params 1
// Size: 0x44
function mark_remaining_as_died_poorly( var0 )
{
    wait 1;
    
    if ( isdefined( var0 ) && isdefined( var0.managevehiclehealthui ) && isdefined( var0.managevehiclehealthui.arenaflag ) && isdefined( var0.managevehiclehealthui.arenaflag.flagmodel ) )
    {
        return;
    }
}

// Params 1
// Size: 0x3b
function calloutmarkerping_watchwhenobjectivedeleted( var0 )
{
    if ( var0 )
    {
        scripts\mp\gameobjects::allowuse( "any" );
        self.trigger scripts\engine\utility::trigger_on();
        return;
    }
    
    scripts\mp\gameobjects::allowuse( "none" );
    self.trigger scripts\engine\utility::trigger_off();
    scripts\mp\gameobjects::resetcaptureprogress();
}

// Params 4
// Size: 0x7d
function calloutmarkerping_watchwhenobjectivestartsprogress( var0, var1, var2, var3 )
{
    self notify( "arenaFlag_setVisible" );
    
    if ( var1 )
    {
        var4 = "waypoint_captureneutral";
        
        if ( istrue( var2 ) )
        {
            var4 = level.squadspawndebug;
        }
        
        thread calloutmarkerping_squadleaderbeaconshouldcreate( var0 );
        thread scripts\mp\gameobjects::setobjectivestatusicons( var4 );
        thread scripts\mp\gameobjects::setownerteam( "neutral" );
        thread scripts\mp\gametypes\obj_dom::updateflagstate( "idle", 0, "none" );
        self.flagmodel show();
        thread calloutmarkerpingvo_createcalloutbattlechatter( var0, 1 );
        
        if ( !istrue( var2 ) )
        {
            ref_13193( var0, 1 );
            return;
        }
        
        return;
    }
    
    thread calloutmarkerpingvo_calculatesounddebouncelength( var0, var2, var3 );
}

// Params 3
// Size: 0x67
function calloutmarkerpingvo_calculatesounddebouncelength( var0, var1, var2 )
{
    self endon( "arenaFlag_setVisible" );
    self endon( "death_or_disconnect" );
    
    if ( !istrue( var2 ) )
    {
        objective_setpinned( self.objidnum, 0 );
        wait 1;
    }
    
    thread calloutmarkerpingvo_createcalloutbattlechatter( var0, 0 );
    thread calloutmarkerping_squadleaderbeaconplayerfirstlanded( var2 );
    thread scripts\mp\gametypes\obj_dom::updateflagstate( "off", 0, "none" );
    self.flagmodel hide( 1 );
    
    if ( !istrue( var1 ) )
    {
        ref_13193( var0, 0 );
        ref_13194( var0, 0 );
        return;
    }
}

// Params 2
// Size: 0x55
function calloutmarkerpingvo_canplaywithspamavoidance( var0, var1 )
{
    var1 endon( "death_or_disconnect" );
    
    if ( var0 )
    {
        var1 setclientomnvar( "ui_overtime_timer_show", 1 );
        objective_addclienttomask( self.objidnum, var1 );
    }
    else
    {
        objective_unpinforclient( self.objidnum, var1 );
        wait 1;
        var1 setclientomnvar( "ui_overtime_timer_show", 0 );
        objective_removeclientfrommask( self.objidnum, var1 );
    }
    
    thread calloutmarkerpingvo_debouncegarbagecollector( var0, var1 );
}

// Params 2
// Size: 0x1e
function calloutmarkerping_watchplayerdeathordisconnect( var0, var1 )
{
    thread calloutmarkerping_watchwhenobjectivestartsprogress( var0, 1, 1 );
    wait var1;
    thread calloutmarkerping_watchwhenobjectivestartsprogress( var0, 0, 1, 1 );
}

// Params 1
// Size: 0x76
function calloutmarkerping_squadleaderbeaconshouldcreate( var0 )
{
    objective_removeallfrommask( self.objidnum );
    
    foreach ( var2 in var0.jailedplayers )
    {
        objective_addclienttomask( self.objidnum, var2 );
    }
    
    foreach ( var2 in var0.arenaplayers )
    {
        objective_addclienttomask( self.objidnum, var2 );
    }
    
    objective_showtoplayersinmask( self.objidnum );
}

// Params 1
// Size: 0x20
function calloutmarkerping_squadleaderbeaconplayerfirstlanded( var0 )
{
    objective_setshowprogress( self.objidnum, 0 );
    objective_removeallfrommask( self.objidnum );
    objective_showtoplayersinmask( self.objidnum );
}

// Params 2
// Size: 0x8b
function calloutmarkerpingvo_createcalloutbattlechatter( var0, var1 )
{
    if ( var1 )
    {
        if ( var0.jailedplayers.size > 0 )
        {
            self.flagmodel hudoutlineenableforclients( var0.jailedplayers, "outline_nodepth_orange" );
        }
        
        if ( var0.arenaplayers.size > 0 )
        {
            self.flagmodel hudoutlineenableforclients( var0.arenaplayers, "outline_nodepth_orange" );
            return;
        }
        
        return;
    }
    
    if ( var0.jailedplayers.size > 0 )
    {
        self.flagmodel hudoutlinedisableforclients( var0.jailedplayers );
    }
    
    if ( var0.arenaplayers.size > 0 )
    {
        self.flagmodel hudoutlinedisableforclients( var0.arenaplayers );
        return;
    }
}

// Params 2
// Size: 0x24
function calloutmarkerpingvo_debouncegarbagecollector( var0, var1 )
{
    if ( var0 )
    {
        self.flagmodel hudoutlineenableforclient( var1, "outline_nodepth_orange" );
        return;
    }
    
    self.flagmodel hudoutlinedisableforclient( var1 );
}

// Params 1
// Size: 0xf6
function arenaflag_onusebegin( var0 )
{
    var1 = getdvarint( "scr_br_fc_flag_capture_time", 3 );
    var0.iscapturing = 1;
    var2 = scripts\mp\gameobjects::getownerteam();
    
    if ( var2 == "neutral" )
    {
        var0 setclientomnvar( "ui_objective_state", 1 );
    }
    
    self.neutralizing = istrue( level.flagneutralization ) && var2 != "neutral";
    
    if ( !istrue( self.neutralized ) )
    {
        self.didstatusnotify = 0;
    }
    
    var3 = var1;
    scripts\mp\gameobjects::setusetime( var3 );
    
    if ( istrue( level.capturedecay ) )
    {
        thread scripts\mp\gameobjects::useobjectdecay( var0.team );
    }
    
    if ( var3 > 0 )
    {
        foreach ( var5 in self.arena.arenaplayers )
        {
            if ( var5 != var0 && var5.team != var0.team )
            {
                self.prevownerteam = var5.team;
                break;
            }
        }
        
        scripts\mp\gametypes\obj_dom::updateflagcapturestate( var0.team );
        scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_taking", "waypoint_losing" );
        return;
    }
}

// Params 4
// Size: 0x2c
function arenaflag_onuseupdate( var0, var1, var2, var3 )
{
    var4 = scripts\mp\gameobjects::getownerteam();
    
    if ( var1 > 0.05 && var2 && !self.didstatusnotify )
    {
        self.didstatusnotify = 1;
        return;
    }
}

// Params 3
// Size: 0x8d
function arenaflag_onuseend( var0, var1, var2 )
{
    self.didstatusnotify = 0;
    
    if ( var2 )
    {
        scripts\mp\objidpoolmanager::objective_show_progress( self.objidnum, 0 );
    }
    
    if ( isplayer( var1 ) )
    {
        var1.iscapturing = 0;
        var1 setclientomnvar( "ui_objective_state", 0 );
        var1.ui_dom_securing = undefined;
    }
    
    var3 = scripts\mp\gameobjects::getownerteam();
    
    if ( var3 == "neutral" )
    {
        scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_captureneutral" );
        thread scripts\mp\gametypes\obj_dom::updateflagstate( "idle", 0 );
    }
    else
    {
        scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_defend", "waypoint_capture" );
        thread scripts\mp\gametypes\obj_dom::updateflagstate( var3, 0 );
    }
    
    if ( !var2 )
    {
        self.neutralized = 0;
        return;
    }
}

// Params 2
// Size: 0xc1
function calloutmarkerping_watchwhenmissioncompletes( var0, var1 )
{
    scripts\mp\gameobjects::setownerteam( var0 );
    self notify( "capture", var1 );
    self notify( "assault", var1 );
    scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_defending", "waypoint_capture" );
    self.neutralized = 0;
    thread scripts\mp\gametypes\obj_dom::updateflagstate( var0, 0, var0 );
    
    if ( self.touchlist[ var0 ].size == 0 && isdefined( self.oldtouchlist ) )
    {
        self.touchlist = self.oldtouchlist;
    }
    
    foreach ( var3 in self.arena.arenaplayers )
    {
        if ( var3 != var1 && var3.team != var0 && isdefined( self.assisttouchlist[ var3.team ] ) )
        {
            self.assisttouchlist[ var3.team ] = [];
            break;
        }
    }
}

// Params 1
// Size: 0x87
function arenaflag_onuse( var0 )
{
    var1 = var0.team;
    self.capturetime = gettime();
    self.neutralized = 0;
    calloutmarkerping_watchwhenmissioncompletes( var1, var0 );
    
    if ( !self.neutralized )
    {
        foreach ( var3 in self.arena.arenaplayers )
        {
            if ( isalive( var3 ) && var3.team != var1 )
            {
                thread set_respawn_loc_delayed( var3 );
            }
        }
        
        thread handleendarena( self.arena );
        self.firstcapture = 0;
        return;
    }
}

// Params 0
// Size: 0x25
function arenaflag_oncontested()
{
    scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_contested" );
    scripts\mp\objidpoolmanager::objective_set_progress_team( self.objidnum, undefined );
    thread scripts\mp\gametypes\obj_dom::updateflagstate( "contested", 0 );
}

// Params 2
// Size: 0x196
function registercontrolledcallback( var0, var1 )
{
    var2 = 0;
    var3 = 0;
    var4 = "";
    
    switch ( var0 )
    {
        case "playerArena0":
            var5 = [ 0, 8, "ui_br_gulag_players_1" ];
            var2 = var5[ 0 ];
            var3 = var5[ 1 ];
            var4 = var5[ 2 ];
            var5 = undefined;
            var1 += 1;
            break;
        case "playerArena1":
            var6 = [ 8, 8, "ui_br_gulag_players_1" ];
            var2 = var6[ 0 ];
            var3 = var6[ 1 ];
            var4 = var6[ 2 ];
            var6 = undefined;
            var1 += 1;
            break;
        case "playerJail0":
            var7 = [ 16, 8, "ui_br_gulag_players_1" ];
            var2 = var7[ 0 ];
            var3 = var7[ 1 ];
            var4 = var7[ 2 ];
            var7 = undefined;
            var1 += 1;
            break;
        case "playerJail1":
            var8 = [ 24, 8, "ui_br_gulag_players_1" ];
            var2 = var8[ 0 ];
            var3 = var8[ 1 ];
            var4 = var8[ 2 ];
            var8 = undefined;
            var1 += 1;
            break;
        case "loadoutRow":
            var9 = [ 0, 8, "ui_br_gulag_data" ];
            var2 = var9[ 0 ];
            var3 = var9[ 1 ];
            var4 = var9[ 2 ];
            var9 = undefined;
            var1 += 1;
            break;
        case "playerHealth0":
            var10 = [ 8, 8, "ui_br_gulag_data" ];
            var2 = var10[ 0 ];
            var3 = var10[ 1 ];
            var4 = var10[ 2 ];
            var10 = undefined;
            break;
        case "playerHealth1":
            var11 = [ 16, 8, "ui_br_gulag_data" ];
            var2 = var11[ 0 ];
            var3 = var11[ 1 ];
            var4 = var11[ 2 ];
            var11 = undefined;
            break;
        default:
            break;
    }
    
    return [ var2, var3, var4, var1 ];
}

// Params 5
// Size: 0x45
function ref_121b3( var0, var1, var2, var3, var4 )
{
    var5 = int( pow( 2, var4 ) ) - 1;
    var6 = ( var2 & var5 ) << var3;
    var7 = ~( var5 << var3 );
    var8 = var0.ref_11fcf[ var1 ];
    var9 = var8 & var7;
    var10 = var9 + var6;
    var0.ref_11fcf[ var1 ] = var10;
}

// Params 3
// Size: 0x3f
function ref_13125( var0, var1, var2 )
{
    var3 = registercontrolledcallback( var1, var2 );
    var4 = var3[ 0 ];
    var5 = var3[ 1 ];
    var6 = var3[ 2 ];
    var2 = var3[ 3 ];
    var3 = undefined;
    
    if ( var6 == "" )
    {
        return;
    }
    
    ref_121b3( var0, var6, var2, var4, var5 );
}

// Params 3
// Size: 0x1d
function ref_13127( var0, var1, var2 )
{
    var3 = -1;
    
    if ( isdefined( var2 ) )
    {
        var3 = var2 getentitynumber();
    }
    
    ref_13125( var0, var1, var3 );
}

// Params 3
// Size: 0x1f
function ref_13126( var0, var1, var2 )
{
    var3 = 0;
    
    if ( isdefined( var2 ) )
    {
        var3 = var2.health;
    }
    
    ref_13125( var0, var1, var3 );
}

// Params 1
// Size: 0x13f
function ref_13fc1( var0 )
{
    var0.ref_11fcf[ "ui_br_gulag_players_1" ] = 0;
    
    for ( var1 = 0; var1 < level.gulag.maxplayers ; var1++ )
    {
        var2 = var0.arenaplayers[ var1 ];
        ref_13127( var0, "playerArena" + var1, var2 );
    }
    
    var3 = var0.matches[ 0 ];
    
    if ( !isdefined( var3 ) )
    {
        var3 = [];
    }
    
    ref_13127( var0, "playerJail0", var3[ 0 ] );
    ref_13127( var0, "playerJail1", var3[ 1 ] );
    var4 = scripts\engine\utility::array_combine( var0.jailedplayers, var0.arenaplayers );
    
    foreach ( var2 in var4 )
    {
        var2 setclientomnvar( "ui_br_gulag_players_1", var0.ref_11fcf[ "ui_br_gulag_players_1" ] );
        
        foreach ( var7 in var0.matches )
        {
            if ( isdefined( var7[ 0 ] ) && var2 == var7[ 0 ] || isdefined( var7[ 1 ] ) && var2 == var7[ 1 ] )
            {
                var8 = !updatelootleadermarks( var0, var2 );
                var9 = var11 + 1;
                var10 = var8 + ( var9 << 1 );
                var2 setclientomnvar( "ui_br_gulag_queue_position", var10 );
                break;
            }
        }
    }
}

// Params 1
// Size: 0x1b
function ref_1267a( var0 )
{
    self setclientomnvar( "ui_br_gulag_data", var0.ref_11fcf[ "ui_br_gulag_data" ] );
}

// Params 1
// Size: 0x9b
function ref_13fc0( var0 )
{
    ref_12c6b( var0 );
    
    for ( var1 = 0; var1 < level.gulag.maxplayers ; var1++ )
    {
        var2 = var0.arenaplayers[ var1 ];
        ref_13126( var0, "playerHealth" + var1, var2 );
    }
    
    foreach ( var2 in var0.jailedplayers )
    {
        ref_1267a( var2, var0 );
    }
    
    foreach ( var2 in var0.arenaplayers )
    {
        ref_1266d( var2, var0 );
    }
}

// Params 1
// Size: 0x13
function ref_12c6b( var0 )
{
    var0.ref_11fcf[ "ui_br_gulag_data" ] = 0;
}

// Params 1
// Size: 0x37
function ref_1266d( var0 )
{
    if ( !isdefined( self.set_relic_team_proximity ) )
    {
        self setclientomnvar( "ui_br_gulag_data", var0.ref_11fcf[ "ui_br_gulag_data" ] );
        return;
    }
    
    ref_12687( var0, "loadoutRow", self.set_relic_team_proximity );
}

// Params 3
// Size: 0x3f
function ref_12687( var0, var1, var2 )
{
    var3 = registercontrolledcallback( var1, var2 );
    var4 = var3[ 0 ];
    var5 = var3[ 1 ];
    var6 = var3[ 2 ];
    var2 = var3[ 3 ];
    var3 = undefined;
    
    if ( var6 == "" )
    {
        return;
    }
    
    ref_1260f( var0, var6, var2, var4, var5 );
}

// Params 5
// Size: 0x41
function ref_1260f( var0, var1, var2, var3, var4 )
{
    var5 = int( pow( 2, var4 ) ) - 1;
    var6 = ( var2 & var5 ) << var3;
    var7 = ~( var5 << var3 );
    var8 = var0.ref_11fcf[ var1 ];
    var9 = var8 & var7;
    var10 = var9 + var6;
    self setclientomnvar( var1, var10 );
}

// Params 1
// Size: 0x12
function ref_14009( var0 )
{
    ref_13fc1( var0 );
    ref_13fc0( var0 );
}

// Params 1
// Size: 0x4e
function ref_12526( var0 )
{
    var1 = getarraykeys( var0.ref_11fcf );
    
    foreach ( var3 in var1 )
    {
        self setclientomnvar( var3, 0 );
    }
    
    self setclientomnvar( "ui_overtime_timer", 0 );
    self setclientomnvar( "ui_overtime_timer_show", 0 );
}

// Params 2
// Size: 0x67
function ref_13194( var0, var1 )
{
    foreach ( var3 in var0.arenaplayers )
    {
        var3 setclientomnvar( "ui_overtime_timer", var1 );
    }
    
    foreach ( var3 in var0.jailedplayers )
    {
        var3 setclientomnvar( "ui_overtime_timer", var1 );
    }
}

// Params 2
// Size: 0x67
function ref_13193( var0, var1 )
{
    foreach ( var3 in var0.arenaplayers )
    {
        var3 setclientomnvar( "ui_overtime_timer_show", var1 );
    }
    
    foreach ( var3 in var0.jailedplayers )
    {
        var3 setclientomnvar( "ui_overtime_timer_show", var1 );
    }
}

// Params 1
// Size: 0x72
function ref_125cc( var0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "gulag_end" );
    var1 = "playerHealth0";
    
    if ( var0.arenaplayers[ 0 ] != self )
    {
        var1 = "playerHealth1";
    }
    
    for ( ;; )
    {
        ref_13fc0( var0 );
        
        if ( self.health <= 0 )
        {
            return;
        }
        
        scripts\engine\utility::ref_143aa( "damage", "force_regeneration", "removeAdrenaline", "healed", "healhRegenThink", "vampirism", "spawned_player" );
    }
}

// Params 0
// Size: 0x25
function ref_1263c()
{
    if ( level.gulag.trial_target_civilian_killed_func && !isbot( self ) )
    {
        var0 = relic_amped_pick_new_victim();
        self skydive_cutparachuteon( var0 );
        return;
    }
}

// Params 0
// Size: 0x7c
function ref_12617()
{
    if ( level.gulag.trial_target_civilian_killed_func && !isbot( self ) )
    {
        self setclientomnvar( "ui_br_bink_overlay_state", 1 );
        var0 = scripts\mp\music_and_dialog::reset_attack_next_available_time( "br_gulag_intro" );
        self setplayermusicstate( var0 );
        
        if ( scripts\mp\gametypes\br_public::tutorial_playsound() )
        {
            self setsoundsubmix( "iw8_br_gulag_tutorial", 0.5 );
        }
        else
        {
            self setsoundsubmix( "fade_to_black_all_except_music_and_scripted5", 0.5 );
        }
        
        var1 = relic_amped_pick_new_victim();
        self preloadcinematicforplayer( var1 );
        self.ref_12742 = 1;
        return;
    }
    
    gulagloadingtext();
}

// Params 0
// Size: 0xe
function ref_12694()
{
    self setclientomnvar( "ui_br_bink_overlay_state", 2 );
}

// Params 1
// Size: 0x4e
function ref_126ea( var0 )
{
    if ( level.gulag.trial_target_civilian_killed_func && !isbot( self ) && !self calloutmarkerping_getent() )
    {
        self freezecontrols( 1 );
        allplayers_setfov( var0 );
        self freezecontrols( 0 );
        self setclientomnvar( "ui_br_bink_overlay_state", 5 );
        self skydive_cutparachuteoff();
        self.ref_12742 = undefined;
        return;
    }
}

// Params 1
// Size: 0x37
function allplayers_setfov( var0 )
{
    self endon( "bink_complete" );
    var1 = relic_amped_paused();
    
    while ( gettime() - var0 < var1 && !self crouchbuttonpressed() && !self usebuttonpressed() && !self jumpbuttonpressed() )
    {
        waitframe();
    }
}

// Params 2
// Size: 0x18
function ref_12521( var0, var1 )
{
    if ( var0 == "bink_complete" )
    {
        self notify( "bink_complete" );
        return;
    }
}

// Params 0
// Size: 0x2e, Type: bool
function ref_125eb()
{
    if ( scripts\mp\utility\game::getgametype() != "br" )
    {
        return false;
    }
    
    var0 = self calloutmarkerping_entityzoffset( "ui_br_bink_overlay_state" );
    
    if ( var0 != 0 && var0 != 6 )
    {
        return true;
    }
    
    return false;
}

// Params 0
// Size: 0x12, Type: bool
function ref_125ea()
{
    var0 = self calloutmarkerping_entityzoffset( "ui_br_bink_overlay_state" );
    return var0 == 7;
}

// Params 0
// Size: 0xe
function ref_12522()
{
    self setclientomnvar( "ui_br_bink_overlay_state", 7 );
}

// Params 1
// Size: 0x73
function ref_12523( var0 )
{
    self endon( "disconnect" );
    self endon( "playerCinematicFadeOutForceEnd" );
    
    if ( ref_125eb() )
    {
        if ( isdefined( var0 ) )
        {
            wait var0;
        }
        
        if ( getdvarint( "scr_br_bink_overlay_log", 0 ) == 1 )
        {
            logstring( "bnk_playerCinematicFadeOut()" );
            logstring( "bnk_Player " + self.name + " ui_br_bink_overlay_state : " + self calloutmarkerping_entityzoffset( "ui_br_bink_overlay_state", 0 ) );
        }
        
        self setclientomnvar( "ui_br_bink_overlay_state", 6 );
        wait 1;
        self setclientomnvar( "ui_br_bink_overlay_state", 0 );
        return;
    }
}

// Params 0
// Size: 0x63
function relic_amped_pick_new_victim()
{
    if ( level.mapname == "mp_wz_island" || istrue( level.gulag.untrack_enemy ) )
    {
        return "mp_wz_island_gulag_ch3";
    }
    
    if ( scripts\cp_mp\utility\game_utility::turretdisabled() )
    {
        if ( scripts\cp_mp\utility\game_utility::turretlightsonstate() )
        {
            return "rebirth_pm_gulag_intro";
        }
        
        return "rebirth_gulag_intro";
    }
    
    if ( istrue( level.gulag.ref_11f19 ) )
    {
        return "mp_donetsk_gulag_intro2";
    }
    
    return "mp_donetsk_gulag_intro";
}

// Params 0
// Size: 0x2f
function relic_amped_paused()
{
    if ( level.mapname == "mp_wz_island" )
    {
        return 28000;
    }
    
    if ( istrue( level.gulag.ref_11f19 ) )
    {
        return 35000;
    }
    
    return 17000;
}

// Params 2
// Size: 0xe6
function ref_1322e( var0, var1 )
{
    if ( !level.gulag.ref_14069 )
    {
        return;
    }
    
    if ( !isdefined( var1.target ) )
    {
        return;
    }
    
    var2 = getentarray( var1.target, "targetname" );
    
    if ( var2.size > 1 )
    {
        level.gulag.ref_14069 = 0;
        return;
    }
    
    var1.door = getent( var1.target, "targetname" );
    
    if ( isdefined( var1.door ) )
    {
        var1.door.closed = 1;
        var3 = getent( var1.door.target, "targetname" );
        var3 delete();
        var4 = anglestoforward( var1.door.angles );
        var1.door.heli_rpg_enemy_run_away = var1.door.origin;
        var1.door.ref_1212b = var1.door.origin + var4 * 60;
    }
    
    return var1;
}

// Params 1
// Size: 0x1d, Type: bool
function ref_14069( var0 )
{
    return level.gulag.ref_14069 && var0.get_wave_spawn_total.size > 0;
}

// Params 0
// Size: 0x15
function ref_12c7a()
{
    var0 = self;
    var0.fastcrouchspeedmod = 0;
    var0 scripts\mp\weapons::updatemovespeedscale();
}

#using_animtree( "" );

// Params 2
// Size: 0x1f3
function ref_1251a( var0, var1 )
{
    if ( !level.gulag.getaccessorylogicbyindex )
    {
        return;
    }
    
    self endon( "playerChairBreakoutCleanup" );
    var2 = var1.chair;
    self playerhide();
    self showtoplayer( self );
    var3 = spawn( "script_arms", var2.origin, 0, 0, self );
    var3.angles = var2.angles;
    var3 useanimtree( #animtree );
    var3 hide();
    var3 showtoplayer( self );
    self.ref_12651 = var3;
    var4 = spawn( "script_model", var2.origin );
    var4.angles = var2.angles;
    var4 setmodel( "misc_vm_gulag_cuffs" );
    var4 useanimtree( $ );
    var4 hide();
    var4 showtoplayer( self );
    self.straps = var4;
    self setorigin( var2.origin );
    self playerlinktoabsolute( var3, "tag_player" );
    ref_1251c( 1 );
    thread ref_1251d( var3, var4 );
    self playanimscriptsceneevent( "scripted_scene", "gulag_chair_breakout_start" );
    var3 animscripted( "chair", var2.origin, var2.angles, %sdr_mp_gulag_breakout_wz_2_start_plr );
    var3 scriptmodelplayanim( "sdr_mp_gulag_breakout_wz_2_start_plr" );
    var4 animscripted( "chair", var2.origin, var2.angles, %sdr_mp_gulag_breakout_wz_2_start_straps );
    var4 scriptmodelplayanim( "sdr_mp_gulag_breakout_wz_2_start_straps" );
    var3 waittillmatch( "chair", "end" );
    thread ref_1251e();
    self playerlinkto( var3, "tag_player", 0, 30, 30, 45, 60, 0 );
    var3 hide();
    var3 showtoplayer( self );
    ref_12600( var3, var4, var2 );
    self playanimscriptsceneevent( "scripted_scene", "gulag_chair_breakout_exit" );
    var3 animscripted( "chair", var2.origin, var2.angles, %sdr_mp_gulag_breakout_wz_2_exit_plr );
    var3 scriptmodelplayanim( "sdr_mp_gulag_breakout_wz_2_exit_plr" );
    var4 animscripted( "chair", var2.origin, var2.angles, %sdr_mp_gulag_breakout_wz_2_exit_straps );
    var4 scriptmodelplayanim( "sdr_mp_gulag_breakout_wz_2_exit_straps" );
    var3 waittillmatch( "chair", "end" );
    thread ref_1251b( var3, var4 );
}

// Params 3
// Size: 0x8b
function ref_12600( var0, var1, var2 )
{
    self endon( "playerChairBreakoutCleanup" );
    self endon( "chairBreakout" );
    
    for ( ;; )
    {
        self playanimscriptsceneevent( "scripted_scene", "gulag_chair_breakout_loop" );
        var0 animscripted( "chair", var2.origin, var2.angles, %sdr_mp_gulag_breakout_wz_2_loop_plr );
        var0 scriptmodelplayanim( "sdr_mp_gulag_breakout_wz_2_loop_plr" );
        var1 animscripted( "chair", var2.origin, var2.angles, %sdr_mp_gulag_breakout_wz_2_loop_straps );
        var1 scriptmodelplayanim( "sdr_mp_gulag_breakout_wz_2_loop_straps" );
        var0 waittillmatch( "chair", "end" );
    }
}

// Params 0
// Size: 0x8c
function ref_1251e()
{
    self endon( "playerChairBreakoutCleanup" );
    self endon( "disconnect" );
    wait 1;
    
    for ( ;; )
    {
        if ( isdefined( self ) )
        {
            var0 = self getnormalizedmovement();
            
            if ( self usebuttonpressed() || self jumpbuttonpressed() || var0[ 0 ] > 0.5 || var0[ 1 ] > 0.5 )
            {
                break;
            }
        }
        
        waitframe();
    }
    
    self playerlinktoabsolute( self.ref_12651, "tag_player" );
    self.ref_12651 hide();
    self.ref_12651 showtoplayer( self );
    self.straps hide();
    self.straps showtoplayer( self );
    self notify( "chairBreakout" );
}

// Params 0
// Size: 0x12
function ref_1251f()
{
    ref_1251b( self.ref_12651, self.straps );
}

// Params 2
// Size: 0x59
function ref_1251b( var0, var1 )
{
    if ( !level.gulag.getaccessorylogicbyindex )
    {
        return;
    }
    
    if ( !isdefined( self.ref_12651 ) )
    {
        return;
    }
    
    if ( isdefined( self ) )
    {
        self unlink();
        self stopanimscriptsceneevent();
        self playershow( 1 );
        ref_1251c( 0 );
        self.ref_12651 = undefined;
        self.straps = undefined;
        self notify( "playerChairBreakoutCleanup" );
    }
    
    var0 delete();
    var1 delete();
}

// Params 2
// Size: 0x1c
function ref_1251d( var0, var1 )
{
    self endon( "playerChairBreakoutCleanup" );
    self waittill( "death_or_disconnect" );
    thread ref_1251b( var0, var1 );
}

// Params 1
// Size: 0x27
function ref_1251c( var0 )
{
    if ( var0 )
    {
        self disableweapons();
    }
    else
    {
        self enableweapons();
    }
    
    var1 = !var0;
    self allowmelee( var1 );
    self allowfire( var1 );
}

// Params 1
// Size: 0x51
function reset_minigun_shot_count( var0 )
{
    if ( isdefined( var0.getactiveforteam ) )
    {
        var0.getactiveforteam++;
        var0.getactiveforteam %= var0.getactiveteamcount.size;
    }
    else
    {
        var0.getactiveforteam = 0;
    }
    
    var1 = var0.getactiveteamcount[ var0.getactiveforteam ];
    return var1;
}

// Params 0
// Size: 0x3b1
function ref_1327f()
{
    if ( !istrue( level.gulag.ref_142fb ) )
    {
        return;
    }
    
    level.gulag.hud_y_offset = [];
    var0 = 0;
    level.gulag.hud_y_offset[ var0 ] = spawnstruct();
    level.gulag.hud_y_offset[ var0 ].brclampdamagealtmodegg = "dx_brm_rm1_gulag_muffled_chatter_";
    level.gulag.hud_y_offset[ var0 ].aliases = [ 10, 20, 30, 40 ];
    level.gulag.hud_y_offset[ var0 ].ks_circledelaytime = [ 1, 1, 1, 0 ];
    var0++;
    level.gulag.hud_y_offset[ var0 ] = spawnstruct();
    level.gulag.hud_y_offset[ var0 ].brclampdamagealtmodegg = "dx_brm_rm1_gulag_muffled_chatter_";
    level.gulag.hud_y_offset[ var0 ].aliases = [ 90, 100, 110 ];
    level.gulag.hud_y_offset[ var0 ].ks_circledelaytime = [ 1, 1, 0 ];
    var0++;
    level.gulag.hud_y_offset[ var0 ] = spawnstruct();
    level.gulag.hud_y_offset[ var0 ].brclampdamagealtmodegg = "dx_brm_rm2_gulag_announcement_";
    level.gulag.hud_y_offset[ var0 ].aliases = [ 10 ];
    level.gulag.hud_y_offset[ var0 ].ks_circledelaytime = [ 0 ];
    var0++;
    level.gulag.hud_y_offset[ var0 ] = spawnstruct();
    level.gulag.hud_y_offset[ var0 ].brclampdamagealtmodegg = "dx_brm_rm2_gulag_announcement_";
    level.gulag.hud_y_offset[ var0 ].aliases = [ 20 ];
    level.gulag.hud_y_offset[ var0 ].ks_circledelaytime = [ 0 ];
    var0++;
    level.gulag.hud_y_offset[ var0 ] = spawnstruct();
    level.gulag.hud_y_offset[ var0 ].brclampdamagealtmodegg = "dx_brm_rm2_gulag_announcement_";
    level.gulag.hud_y_offset[ var0 ].aliases = [ 30 ];
    level.gulag.hud_y_offset[ var0 ].ks_circledelaytime = [ 0 ];
    var0++;
    level.gulag.hud_y_offset[ var0 ] = spawnstruct();
    level.gulag.hud_y_offset[ var0 ].brclampdamagealtmodegg = "dx_brm_rm2_gulag_announcement_";
    level.gulag.hud_y_offset[ var0 ].aliases = [ 40 ];
    level.gulag.hud_y_offset[ var0 ].ks_circledelaytime = [ 0 ];
    var0++;
    level.gulag.hud_y_offset[ var0 ] = spawnstruct();
    level.gulag.hud_y_offset[ var0 ].brclampdamagealtmodegg = "dx_brm_rm2_gulag_recording_";
    level.gulag.hud_y_offset[ var0 ].aliases = [ 10 ];
    level.gulag.hud_y_offset[ var0 ].ks_circledelaytime = [ 0 ];
    var0++;
    level.gulag.hud_y_offset[ var0 ] = spawnstruct();
    level.gulag.hud_y_offset[ var0 ].brclampdamagealtmodegg = "dx_brm_rm2_gulag_recording_";
    level.gulag.hud_y_offset[ var0 ].aliases = [ 20, 30, 40, 50, 60, 20, 70, 80, 90, 80, 20, 30, 100, 110 ];
    level.gulag.hud_y_offset[ var0 ].ks_circledelaytime = [ 0.5, 1, 1.5, 0.7, 0.3, 1, 0.4, 0.8, 1, 0.5, 1, 1.5, 2, 0 ];
    var0++;
    level.gulag.hud_y_offset = scripts\engine\utility::array_randomize( level.gulag.hud_y_offset );
}

// Params 1
// Size: 0x141
function ref_13882( var0 )
{
    if ( !istrue( level.gulag.ref_142fb ) || var0.ref_12d93.size == 0 )
    {
        return;
    }
    
    var0.ref_142fa = spawn( "script_model", var0.origin );
    var0.ref_142fa setmodel( "tag_origin" );
    var1 = randomint( level.gulag.hud_y_offset.size );
    var2 = randomint( var0.ref_12d93.size );
    
    for ( ;; )
    {
        ref_14407();
        
        while ( var0.jailedplayers.size == 0 )
        {
            waitframe();
        }
        
        var5 = var0.ref_12d93[ var2 ];
        var6 = level.gulag.hud_y_offset[ var1 ];
        var0.ref_142fa.origin = var5.origin;
        var0.ref_142fa dontinterpolate();
        waitframe();
        
        for ( var7 = 0; var7 < var6.aliases.size ; var7++ )
        {
            var8 = var6.brclampdamagealtmodegg + var6.aliases[ var7 ];
            var0.ref_142fa playsoundonmovingent( var8 );
            var9 = lookupsoundlength( var8, 1 ) / 1000;
            var10 = var6.ks_circledelaytime[ var7 ] + var9;
            wait var10;
        }
        
        var2 = randomint( var0.ref_12d93.size );
        var1++;
        
        if ( var1 >= level.gulag.hud_y_offset.size )
        {
            var1 = 0;
        }
    }
}

// Params 0
// Size: 0x23
function ref_14407()
{
    var0 = getdvarint( "scr_br_gulag_voice_min", 90 );
    var1 = getdvarint( "scr_br_gulag_voice_max", 180 );
    var2 = randomfloatrange( var0, var1 );
    wait var2;
}

