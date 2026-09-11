
// Params 0
// Size: 0x12f
function init()
{
    var0 = scripts\mp\gametypes\br_quest_util::registerquestcategory( "black_market", 1 );
    
    if ( !var0 )
    {
        return;
    }
    
    level.’Ê‰°­¯k…NµÊG¯º²Ü£ = spawnstruct();
    init_dvars();
    scripts\mp\gametypes\br_quest_util::registerremovequestinstance( "black_market", &on_remove_quest_instance );
    scripts\mp\gametypes\br_quest_util::registeronplayerkilled( "black_market", &ref_11ff1 );
    scripts\mp\gametypes\br_quest_util::ref_12b2e( "black_market", &on_player_disconnect );
    scripts\mp\gametypes\br_quest_util::ref_12b2d( "black_market", &on_enter_gulag );
    scripts\mp\gametypes\br_quest_util::ref_12b30( "black_market", &on_respawn );
    scripts\mp\gametypes\br_quest_util::registerquestcircletick( "black_market", &on_circle_tick );
    scripts\mp\gametypes\br_quest_util::ref_1297c( "black_market", 1 );
    scripts\mp\gametypes\br_quest_util::ref_12b31( "black_market", &on_timer_expired );
    thread contract_cleanup_watcher();
    game[ "dialog" ][ "mission_blm_accept" ] = "mission_mission_gen_accept";
    game[ "dialog" ][ "mission_blm_dropnotify" ] = "blkmrkt_contract_contract_start";
    game[ "dialog" ][ "mission_blm_success" ] = "blkmrkt_contract_contract_complete";
    game[ "dialog" ][ "mission_blm_fail" ] = "blkmrkt_contract_contract_fail";
    game[ "dialog" ][ "mission_blm_timer_warn" ] = "blkmrkt_contract_timer_remaining";
    game[ "dialog" ][ "mission_blm_kiosk_nearby" ] = "blkmrkt_contract_buy_station_proximity";
    scripts\engine\scriptable::ref_12f5b( "br_black_market_kiosk", &kiosk_on_use );
    scripts\mp\utility\sound::besttime( "br_event_black_market" );
}

// Params 0
// Size: 0x1c9
function init_dvars()
{
    level.’Ê‰°­¯k…NµÊG¯º²Ü£.ºk¢ÉÓs¿K%Gd³Pg = getdvarint( "scr_br_black_market_quest_time", 120 );
    level.’Ê‰°­¯k…NµÊG¯º²Ü£.¥ËûşX/:Rëé@Gî-M8h
3É— = getdvarint( "scr_br_black_market_circle_index_to_hide", 4 );
    level.’Ê‰°­¯k…NµÊG¯º²Ü£.Š‡õgj˜çcöyšËFˆ‡	{ÌÖ° = getdvarfloat( "scr_br_black_market_quest_circle_delay", 1.5 );
    level.’Ê‰°­¯k…NµÊG¯º²Ü£.½ïT Ù3wÙ“˜h6Ë×NŞSû = getdvarint( "scr_br_black_market_drop_notify_radius", 10000 );
    level.’Ê‰°­¯k…NµÊG¯º²Ü£.º%¥¯Ú–ŞÜµ×F•n£N·/ú£Z¶+{]è = getdvarint( "scr_br_black_market_kiosk_destroy_timeout", 120 );
    level.’Ê‰°­¯k…NµÊG¯º²Ü£.‡W´¾\®Vn}–'ÊõÍè°'è¯'°È¥ºæ = getdvarint( "scr_br_black_market_quest_circle_start_radius", 4000 );
    level.’Ê‰°­¯k…NµÊG¯º²Ü£.¬Şq—Û-ã·ä(àŒB—ÔQ=-F0IxB = getdvarint( "scr_br_black_market_quest_circle_end_radius", 500 );
    level.’Ê‰°­¯k…NµÊG¯º²Ü£.ƒm€—H3–KßR£½#¸¿Z“ç = getdvarint( "scr_br_black_market_quest_circle_steps", 3 );
    level.’Ê‰°­¯k…NµÊG¯º²Ü£.™±xù×¸I³à}O÷PX5ãŸ = getdvarfloat( "scr_br_black_market_audio_ping_interval", 2 );
    level.’Ê‰°­¯k…NµÊG¯º²Ü£.‡´×#YÌjY€‚¤>W™È I‹Ë“òãĞ = getdvarfloat( "scr_br_black_market_audio_echo_min_interval", 0.1 );
    level.’Ê‰°­¯k…NµÊG¯º²Ü£.™ôÌë…«F¥íú•Æ¡öú¶á×´ÜG¬œ;,6 = getdvarfloat( "scr_br_black_market_audio_echo_max_interval", 0.9 );
    level.’Ê‰°­¯k…NµÊG¯º²Ü£.“Ya5¨ÜïÇ»D(èºĞæÛoàø÷ = getdvarfloat( "scr_br_black_market_audio_echo_min_range", 100 );
    level.’Ê‰°­¯k…NµÊG¯º²Ü£.­Ãßh;ûÛ˜‰Òá£yĞ ·…¯õ = getdvarfloat( "scr_br_black_market_audio_echo_max_range", 5000 );
    level.’Ê‰°­¯k…NµÊG¯º²Ü£.§…¥×­–ö7[ú°±ZÎGÒ·Ü¯“ÂZê¹ = getdvarint( "scr_br_black_market_kiosk_activation_radius", 250 );
    level.’Ê‰°­¯k…NµÊG¯º²Ü£.„ÜRj[Jãpfq‡Øén¡PËjWò = getdvarint( "scr_br_black_market_audio_ping_enabled", 1 );
    level.’Ê‰°­¯k…NµÊG¯º²Ü£.–2Ö¿4à¡É*P;»ze`‡rgq
sBõr  = getdvarint( "scr_br_black_market_circle_shrinking_enabled", 1 );
    level.’Ê‰°­¯k…NµÊG¯º²Ü£.’‡f9ˆaGØÑW°KS›Cè†ß‰èkÒ = squared( getdvarint( "scr_br_black_market_max_spawn_distance", 10000 ) );
    level.’Ê‰°­¯k…NµÊG¯º²Ü£.¸€¡Ä6@ã‰¬èáBbßsJèÒMÁ‰C = squared( getdvarint( "scr_br_black_market_min_spawn_distance", 4000 ) );
    level.’Ê‰°­¯k…NµÊG¯º²Ü£.ŠrRO5h/_eÓØñƒ‹
+P97 = level.’Ê‰°­¯k…NµÊG¯º²Ü£.ºk¢ÉÓs¿K%Gd³Pg + level.’Ê‰°­¯k…NµÊG¯º²Ü£.º%¥¯Ú–ŞÜµ×F•n£N·/ú£Z¶+{]è;
}

// Params 0
// Size: 0xf
function is_enabled()
{
    return scripts\mp\gametypes\br_quest_util::upload_station_players_manager( "black_market", 1 );
}

// Params 0
// Size: 0x2
function __quest_state()
{
    
}

// Params 1
// Size: 0x165
function takequestitem( var0 )
{
    var1 = scripts\mp\gametypes\br_quest_util::createquestinstance( "black_market", self.team, var0.index, var0 );
    var1 scripts\mp\gametypes\br_quest_util::registerteamonquest( self.team, self );
    scripts\mp\gametypes\br_quest_util::searchfunc( self.team, "br_mission_pickup_tablet" );
    var1.semtex_stuckplayer = self;
    var1.team = self.team;
    var1.playerlist = scripts\mp\utility\teams::getteamdata( self.team, "players" );
    hud_setup_visibility( var1 );
    var1 scripts\mp\gametypes\br_quest_util::ref_1297d( level.’Ê‰°­¯k…NµÊG¯º²Ü£.ºk¢ÉÓs¿K%Gd³Pg, 4 );
    thread play_time_warning_dialog( var1 );
    scripts\mp\gametypes\br_quest_util::addquestinstance( "black_market", var1 );
    scripts\mp\gametypes\br_quest_util::ref_13879( "black_market", self, self.team );
    var2 = spawnstruct();
    var2.excludedplayers = [];
    var2.excludedplayers[ 0 ] = var1.semtex_stuckplayer;
    var2.ogangles = [];
    var2.ogangles[ 0 ] = var1.team;
    var2.ref_127d5 = scripts\mp\gametypes\br_quest_util::rewardmodifier( "black_market", scripts\mp\gametypes\br_quest_util::ringing( self.team ) );
    scripts\mp\gametypes\br_quest_util::displayteamsplash( var1.team, "br_black_market_start_team", var2 );
    scripts\mp\gametypes\br_quest_util::displayplayersplash( var1.semtex_stuckplayer, "br_black_market_start_tablet_finder", var2 );
    level thread scripts\mp\gametypes\br_public::dmztutdropcash( "mission_blm_accept", var1.team, var1.semtex_stuckplayer, 1, 0.5 );
    level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "mission_blm_accept", var1.semtex_stuckplayer, 1, 0.5 );
    thread kiosk_spawn();
}

// Params 1
// Size: 0x8b
function handle_fail_quest( var0 )
{
    switch ( var0 )
    {
        case 2:
            scripts\mp\gametypes\br_quest_util::displayteamsplash( self.team, "br_black_market_circle_failure" );
            break;
        case 1:
            scripts\mp\gametypes\br_quest_util::displayteamsplash( self.team, "br_black_market_timer_expired" );
            break;
        default:
            scripts\mp\gametypes\br_quest_util::displayteamsplash( self.team, "br_black_market_failure" );
            break;
    }
    
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback( "mission_blm_fail", self.team, 1, 1 );
    
    if ( isdefined( self.´L¸èã: ) )
    {
        kiosk_destroy( self.´L¸èã: );
        return;
    }
}

// Params 0
// Size: 0x124
function complete_quest()
{
    var0 = spawnstruct();
    var1 = scripts\mp\gametypes\br_quest_util::ringing( self.team );
    var2 = scripts\mp\gametypes\br_quest_util::getquestindex( "black_market" );
    var3 = scripts\mp\gametypes\br_quest_util::rewardtovalue( scripts\mp\gametypes\br_quest_util::rewardtotype( "black_market" ) );
    var4 = scripts\mp\gametypes\br_alt_mode_bblitz::clear_all_remaining( self.semtex_stuckplayer );
    var0.ref_121b5 = scripts\mp\gametypes\br_quest_util::ref_121b9( var2, var1, var3, undefined, var4 );
    scripts\mp\gametypes\br_quest_util::displayteamsplash( self.team, "br_black_market_complete", var0 );
    level thread scripts\mp\gametypes\br_public::dmztutdropcash( "mission_blm_success", self.team, self.semtex_stuckplayer, 1, 0, 0.5 );
    level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "mission_blm_success", self.semtex_stuckplayer, 1, 0, 0.5 );
    self.´L¸èã: setscriptablepartstate( "br_black_market_kiosk", "opening" );
    thread kiosk_destroy_after_delay();
    self.´L¸èã:.ŠİÉ¯C = undefined;
    
    foreach ( var6 in level.players )
    {
        self.´L¸èã: enablescriptableplayeruse( var6 );
    }
    
    self.ref_12d2d = undefined;
    self.ref_12d2e = self.semtex_stuckplayer.origin;
    self.ref_12d2b = self.semtex_stuckplayer.angles;
    self.result = "success";
    thread scripts\mp\gametypes\br_quest_util::removequestinstance();
}

// Params 0
// Size: 0x183
function kiosk_distance_watcher()
{
    level endon( "game_ended" );
    self endon( "marked_to_remove" );
    var0 = scripts\mp\utility\teams::getteamdata( self.team, "players" );
    var1 = squared( level.’Ê‰°­¯k…NµÊG¯º²Ü£.§…¥×­–ö7[ú°±ZÎGÒ·Ü¯“ÂZê¹ );
    var2 = squared( level.’Ê‰°­¯k…NµÊG¯º²Ü£.‡W´¾\®Vn}–'ÊõÍè°'è¯'°È¥ºæ );
    
    for ( ;; )
    {
        foreach ( var4 in var0 )
        {
            if ( !isdefined( var4 ) || !isalive( var4 ) )
            {
                continue;
            }
            
            var5 = distancesquared( var4.origin, self.´L¸èã:.origin );
            
            if ( var5 < var1 )
            {
                var6 = var4 geteye();
                var7 = self.´L¸èã:.origin + ( 0, 0, 32 );
                var8 = physics_createcontents( [ "physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle" ] );
                var9 = [ self.´L¸èã:, var4 ];
                var10 = physics_raycast( var6, var7, var8, var9, 0, "physicsquery_closest", 1 );
                
                if ( !( isdefined( var10 ) && var10.size > 0 ) )
                {
                    show_kiosk();
                    complete_quest();
                }
                
                waitframe();
            }
        }
        
        if ( !self.“ºú`øŸŒ¡­¥  && level.’Ê‰°­¯k…NµÊG¯º²Ü£.–2Ö¿4à¡É*P;»ze`‡rgq
sBõr  )
        {
            var12 = var2;
            
            foreach ( var4 in var0 )
            {
                var12 = min( distance2dsquared( var4.origin, self.›JïH}pàQ¦SÎ×‹% ), var12 );
            }
            
            if ( var12 < self.„ë‚ş €—SQ¥PM÷Àñ«#k>Ğ )
            {
                quest_circle_tick();
            }
        }
        
        wait 1;
    }
}

// Params 0
// Size: 0xb0
function show_kiosk()
{
    if ( self.“ºú`øŸŒ¡­¥  )
    {
        return;
    }
    
    self.“ºú`øŸŒ¡­¥  = 1;
    self notify( "kiosk_found" );
    thread quest_circle_animate( self.“=
z‘¯<«1a5;[ self.ºá-õØZ'cV¾Íè¬8 - 1 ], self.´L¸èã:.origin, 2, 1 );
    var0 = scripts\mp\utility\teams::getteamdata( self.team, "players" );
    
    foreach ( var2 in var0 )
    {
        var2 playlocalsound( "br_black_market_chest_discovered" );
    }
    
    objective_state( self.ref_11f64, "current" );
    objective_setshowoncompass( self.ref_11f64, 0 );
    playencryptedcinematicforall( self.ref_11f64, 0 );
    function_0442( self.ref_11f64, 0 );
    objective_setshowdistance( self.ref_11f64, 1 );
}

// Params 1
// Size: 0x3c
function play_time_warning_dialog( var0 )
{
    level endon( "game_ended" );
    self endon( "marked_to_remove" );
    var1 = max( level.’Ê‰°­¯k…NµÊG¯º²Ü£.ºk¢ÉÓs¿K%Gd³Pg - var0, 0 );
    wait var1;
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback( "mission_blm_timer_warn", self.team, 1, 1 );
}

// Params 0
// Size: 0x6b
function contract_cleanup_watcher()
{
    level endon( "game_ended" );
    
    for ( ;; )
    {
        level waittill( "br_circle_set", var0 );
        
        if ( var0 >= level.’Ê‰°­¯k…NµÊG¯º²Ü£.¥ËûşX/:Rëé@Gî-M8h
3É— )
        {
            var1 = getlootscriptablearrayinradius( scripts\mp\gametypes\br_quest_util::removepatchablecollision_delayed( "black_market" ) );
            
            foreach ( var3 in var1 )
            {
                var3.¹Ì uŠÌˆˆ+Pƒ½ã)OÖG = 1;
                scripts\mp\gametypes\br_pickups::ref_11a21( var3 );
            }
        }
    }
}

// Params 0
// Size: 0x2
function __hud()
{
    
}

// Params 0
// Size: 0x77
function hud_setup_visibility()
{
    var0 = scripts\mp\gametypes\br_quest_util::sortvalidplayersinarray( scripts\mp\utility\teams::getteamdata( self.team, "players" ) );
    
    foreach ( var2 in var0[ "valid" ] )
    {
        var2 scripts\mp\gametypes\br_quest_util::uiobjectiveshow( "black_market" );
    }
    
    foreach ( var2 in var0[ "invalid" ] )
    {
        var2 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
    }
}

// Params 1
// Size: 0x10
function hud_show_to_player( var0 )
{
    var0 scripts\mp\gametypes\br_quest_util::uiobjectiveshow( "black_market" );
}

// Params 1
// Size: 0xb
function hud_hide_from_player( var0 )
{
    var0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
}

// Params 0
// Size: 0x38
function hud_delete()
{
    foreach ( var1 in scripts\mp\utility\teams::getteamdata( self.team, "players" ) )
    {
        hud_hide_from_player( var1 );
    }
}

// Params 0
// Size: 0x2
function __event_handlers()
{
    
}

// Params 0
// Size: 0x3d
function on_remove_quest_instance()
{
    hud_delete();
    scripts\mp\objidpoolmanager::returnreservedobjectiveid( self.ref_11f64 );
    
    if ( isdefined( self.mapcircle ) )
    {
        scripts\mp\gametypes\br_quest_util::lastdirtyscore();
    }
    
    if ( isdefined( self.“ù{˜©ë¥lÛ7ë¶Şì¬N ) )
    {
        self.“ù{˜©ë¥lÛ7ë¶Şì¬N delete();
    }
    
    scripts\mp\gametypes\br_quest_util::releaseteamonquest( self.team );
}

// Params 2
// Size: 0xd
function ref_11ff1( var0, var1 )
{
    on_player_removed( var1, var0 );
}

// Params 1
// Size: 0x7e
function on_player_disconnect( var0 )
{
    if ( var0.team == self.team )
    {
        var1 = scripts\mp\utility\teams::getteamdata( self.team, "players" );
        scripts\mp\gametypes\br_quest_util::getquestinstancedata( "black_market", self.team ).playerlist = var1;
        
        if ( isdefined( self.´L¸èã: ) && var1.size )
        {
            self.´L¸èã: setotherent( var1[ 0 ] );
        }
        
        if ( !scripts\mp\gametypes\br_quest_util::isteamvalid( var0.team ) )
        {
            self.result = "fail";
            scripts\mp\gametypes\br_quest_util::removequestinstance();
        }
    }
    
    on_player_removed( var0 );
}

// Params 1
// Size: 0x12
function on_enter_gulag( var0 )
{
    hud_hide_from_player( var0 );
    scripts\mp\gametypes\br_quest_util::spawn_dogtags( var0 );
}

// Params 1
// Size: 0x2a
function on_respawn( var0 )
{
    if ( var0.team == self.team )
    {
        hud_show_to_player( var0 );
        scripts\mp\gametypes\br_quest_util::ref_1336a( var0 );
        start_player_threads( var0 );
        return;
    }
}

// Params 2
// Size: 0x5
function on_player_removed( var0, var1 )
{
    
}

// Params 0
// Size: 0xa
function on_timer_expired()
{
    handle_fail_quest( 1 );
}

// Params 2
// Size: 0x77
function on_circle_tick( var0, var1 )
{
    if ( scripts\mp\gametypes\br_circle::getsafecircleradius() > 0 )
    {
        var2 = squared( scripts\mp\gametypes\br_circle::getdangercircleradius() );
        
        if ( !isdefined( self.lastcircletick ) )
        {
            self.lastcircletick = -1;
        }
        
        var3 = gettime();
        
        if ( self.lastcircletick == var3 )
        {
            return;
        }
        
        self.lastcircletick = var3;
        
        if ( isdefined( self.´L¸èã: ) )
        {
            var4 = distance2dsquared( self.´L¸èã:.origin, var0 );
            
            if ( var4 > var2 )
            {
                handle_fail_quest( 2 );
                self.result = "fail";
                scripts\mp\gametypes\br_quest_util::removequestinstance();
                return;
            }
            
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x2
function __drop_logic()
{
    
}

// Params 1
// Size: 0xcd
function find_kiosk_spawn_location( var0 )
{
    var1 = [];
    var2 = undefined;
    var3 = -1;
    
    foreach ( var5 in level.’Ê‰°­¯k…NµÊG¯º²Ü£.wait_display_pavelow_boss_health_bar )
    {
        if ( !istrue( var5.available ) || !scripts\mp\gametypes\br_circle::vandalize_minigun_speed( var5.origin, 1, level.’Ê‰°­¯k…NµÊG¯º²Ü£.ºk¢ÉÓs¿K%Gd³Pg ) )
        {
            continue;
        }
        
        var6 = distance2dsquared( var0, var5.origin );
        
        if ( !isdefined( var2 ) || var6 > var3 )
        {
            var2 = var5;
            var3 = var6;
        }
        
        if ( var6 >= level.’Ê‰°­¯k…NµÊG¯º²Ü£.¸€¡Ä6@ã‰¬èáBbßsJèÒMÁ‰C && var6 <= level.’Ê‰°­¯k…NµÊG¯º²Ü£.’‡f9ˆaGØÑW°KS›Cè†ß‰èkÒ )
        {
            var1 = var5;
        }
    }
    
    if ( var1.size > 0 )
    {
        var8 = randomint( var1.size );
        return var1[ var8 ];
    }
    
    if ( isdefined( var3 ) )
    {
        return var3;
    }
    
    return undefined;
}

// Params 0
// Size: 0x2
function __kiosk_logic()
{
    
}

// Params 0
// Size: 0x1bc
function kiosk_spawn()
{
    var0 = undefined;
    var1 = find_kiosk_spawn_location( self.semtex_stuckplayer.origin );
    
    if ( !isdefined( var1 ) )
    {
        waitframe();
        self.result = "no_locale";
        thread scripts\mp\gametypes\br_quest_util::removequestinstance();
        return;
    }
    
    var1.available = 0;
    var0 = spawn( "script_model", var1.origin );
    var0.angles = var1.angles;
    var0 setmodel( "x2_mercenary_buy_station_rig_skeleton" );
    var0 setscriptablepartstate( "br_black_market_kiosk", "visible", 0 );
    var0.¾<ãC¶H—¯ª¸!#W]@¡gOó = 1;
    var0.ŠÓ¥e0{)÷€‡5 = var1;
    var0.visible = 1;
    var0.ŠİÉ¯C = self;
    self.´L¸èã: = var0;
    self.“ºú`øŸŒ¡­¥  = 0;
    self.´L¸èã: setotherent( self.semtex_stuckplayer );
    
    foreach ( var3 in level.players )
    {
        if ( var3.team != self.team )
        {
            var0 disablescriptableplayeruse( var3 );
        }
    }
    
    var5 = spawnstruct();
    var5.excludedplayers = [];
    var5.excludedplayers[ 0 ] = self.semtex_stuckplayer;
    var5.ogangles = [];
    var5.ogangles[ 0 ] = self.team;
    scripts\mp\gametypes\br_quest_util::look_at_heli( "br_black_market_crate_drop", var1.origin, level.’Ê‰°­¯k…NµÊG¯º²Ü£.½ïT Ù3wÙ“˜h6Ë×NŞSû, level.questinfo.defaultfilter, var5 );
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback( "mission_blm_dropnotify", self.team, 1, 1 );
    wait level.’Ê‰°­¯k…NµÊG¯º²Ü£.Š‡õgj˜çcöyšËFˆ‡	{ÌÖ°;
    quest_circle_setup( var1.origin );
    var6 = scripts\mp\utility\teams::getteamdata( self.team, "players" );
    
    foreach ( var3 in var6 )
    {
        scripts\mp\gametypes\br_quest_util::ref_1336a( var3 );
        start_player_threads( var3 );
    }
    
    thread kiosk_distance_watcher();
}

// Params 5
// Size: 0x59
function kiosk_on_use( var0, var1, var2, var3, var4 )
{
    if ( !isdefined( var0.entity ) )
    {
        return;
    }
    
    if ( isdefined( var0.entity.ŠİÉ¯C ) )
    {
        show_kiosk( var0.entity.ŠİÉ¯C );
        complete_quest( var0.entity.ŠİÉ¯C );
    }
    
    thread run_black_market_purchase_menu( var3 );
}

// Params 0
// Size: 0x21
function kiosk_destroy_after_delay()
{
    level endon( "game_ended" );
    self endon( "death" );
    wait level.’Ê‰°­¯k…NµÊG¯º²Ü£.º%¥¯Ú–ŞÜµ×F•n£N·/ú£Z¶+{]è;
    kiosk_destroy();
}

// Params 0
// Size: 0x36
function kiosk_destroy()
{
    self.ŠÓ¥e0{)÷€‡5.available = 1;
    playfx( scripts\engine\utility::getfx( "vfx_br3_pbs_dmg" ), self.origin );
    playsoundatpos( self.origin, "mp_equip_destroyed" );
    self delete();
}

// Params 1
// Size: 0x70
function run_black_market_purchase_menu( var0 )
{
    var1 = self;
    level endon( "game_ended" );
    var1 endon( "disconnect" );
    var1 endon( "death" );
    var1.delay_kick_inactive_player = var0;
    var1 setclientomnvar( "ui_br_purchase_file_override", 8 );
    var1 setclientomnvar( "ui_br_purchase_killstreak_response", 0 );
    var1 setclientomnvar( "ui_br_open_purchase_killstreak", 1 );
    var1.armorykioskpurchaseallowed = 1;
    scripts\mp\gametypes\br_analytics::destructable_car( var1, "menu_open" );
    var1 thread scripts\mp\gametypes\br_armory_kiosk::apc_target_enemies( var0 );
    var1 setsoundsubmix( "iw8_br_plunder_kiosk_menu" );
}

// Params 0
// Size: 0x2
function __kiosk_location()
{
    
}

// Params 2
// Size: 0x5c
function ref_12ae8( var0, var1 )
{
    if ( !isdefined( level.’Ê‰°­¯k…NµÊG¯º²Ü£.wait_display_pavelow_boss_health_bar ) )
    {
        level.’Ê‰°­¯k…NµÊG¯º²Ü£.wait_display_pavelow_boss_health_bar = [];
    }
    
    var2 = spawnstruct();
    var2.origin = var0;
    var2.angles = var1;
    var2.available = 1;
    level.’Ê‰°­¯k…NµÊG¯º²Ü£.wait_display_pavelow_boss_health_bar[ level.’Ê‰°­¯k…NµÊG¯º²Ü£.wait_display_pavelow_boss_health_bar.size ] = var2;
}

// Params 0
// Size: 0x2
function __player_logic()
{
    
}

// Params 1
// Size: 0x24
function start_player_threads( var0 )
{
    if ( self.“ºú`øŸŒ¡­¥  )
    {
        return;
    }
    
    if ( level.’Ê‰°­¯k…NµÊG¯º²Ü£.„ÜRj[Jãpfq‡Øén¡PËjWò )
    {
        thread player_start_audio_ping( var0 );
        return;
    }
}

// Params 1
// Size: 0xbb
function player_start_audio_ping( var0 )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    var0 endon( "marked_to_remove" );
    var0 endon( "kiosk_found" );
    var1 = squared( level.’Ê‰°­¯k…NµÊG¯º²Ü£.“Ya5¨ÜïÇ»D(èºĞæÛoàø÷ );
    var2 = squared( level.’Ê‰°­¯k…NµÊG¯º²Ü£.­Ãßh;ûÛ˜‰Òá£yĞ ·…¯õ );
    var3 = var0.´L¸èã:.origin;
    
    for ( ;; )
    {
        var4 = distance2dsquared( self.origin, var3 );
        
        if ( var4 <= var2 )
        {
            self playlocalsound( "br_black_market_ping_plr" );
            var5 = scripts\engine\math::remap( var4, var1, var2, level.’Ê‰°­¯k…NµÊG¯º²Ü£.‡´×#YÌjY€‚¤>W™È I‹Ë“òãĞ, level.’Ê‰°­¯k…NµÊG¯º²Ü£.™ôÌë…«F¥íú•Æ¡öú¶á×´ÜG¬œ;,6 );
            wait var5;
            self playlocalsound( "br_black_market_echo_plr" );
            wait level.’Ê‰°­¯k…NµÊG¯º²Ü£.™±xù×¸I³à}O÷PX5ãŸ - var5;
            continue;
        }
        
        wait level.’Ê‰°­¯k…NµÊG¯º²Ü£.™±xù×¸I³à}O÷PX5ãŸ;
    }
}

// Params 0
// Size: 0x2
function __quest_circle_logic()
{
    
}

// Params 1
// Size: 0x1ab
function quest_circle_setup( var0 )
{
    var1 = var0 + scripts\engine\math::random_vector_2d() * randomfloatrange( 0, level.’Ê‰°­¯k…NµÊG¯º²Ü£.‡W´¾\®Vn}–'ÊõÍè°'è¯'°È¥ºæ * 0.9 );
    var2 = ( var1[ 0 ], var1[ 1 ], level.’Ê‰°­¯k…NµÊG¯º²Ü£.‡W´¾\®Vn}–'ÊõÍè°'è¯'°È¥ºæ );
    scripts\mp\gametypes\br_quest_util::init_tactical_boxes( 4, 0, 0, var2 );
    self.“=
z‘¯<«1a5; = [];
    var3 = self.guard_spawners - self.´L¸èã:.origin;
    var4 = level.’Ê‰°­¯k…NµÊG¯º²Ü£.¬Şq—Û-ã·ä(àŒB—ÔQ=-F0IxB / level.’Ê‰°­¯k…NµÊG¯º²Ü£.‡W´¾\®Vn}–'ÊõÍè°'è¯'°È¥ºæ;
    var5 = self.´L¸èã:.origin + var3 * var4;
    var5 = ( var5[ 0 ], var5[ 1 ], level.’Ê‰°­¯k…NµÊG¯º²Ü£.¬Şq—Û-ã·ä(àŒB—ÔQ=-F0IxB );
    var6 = 1 / level.’Ê‰°­¯k…NµÊG¯º²Ü£.ƒm€—H3–KßR£½#¸¿Z“ç;
    
    for ( var7 = 0; var7 <= level.’Ê‰°­¯k…NµÊG¯º²Ü£.ƒm€—H3–KßR£½#¸¿Z“ç ; var7++ )
    {
        self.“=
z‘¯<«1a5;[ var7 ] = vectorlerp( self.guard_spawners, var5, var6 * var7 );
    }
    
    self.ºá-õØZ'cV¾Íè¬8 = 0;
    self.›JïH}pàQ¦SÎ×‹% = self.“=
z‘¯<«1a5;[ 1 ];
    self.„ë‚ş €—SQ¥PM÷Àñ«#k>Ğ = squared( self.›JïH}pàQ¦SÎ×‹%[ 2 ] );
    var8 = scripts\mp\objidpoolmanager::requestobjectiveid( 1 );
    
    if ( var8 > -1 )
    {
        self.“ù{˜©ë¥lÛ7ë¶Şì¬N = spawn( "script_model", self.semtex_stuckplayer.origin );
        objective_onentity( var8, self.“ù{˜©ë¥lÛ7ë¶Şì¬N );
        objective_state( var8, "active" );
        objective_setplayintro( var8, 1 );
        objective_setshowoncompass( var8, 1 );
        objective_setshowdistance( var8, 0 );
        playencryptedcinematicforall( var8, 1 );
        getscriptcachecontents( var8, 0.5, 0.7 );
        objective_icon( var8, "ui_mp_br_mapmenu_icon_blackmarket_objective" );
        objective_setbackground( var8, 1 );
        objective_addteamtomask( var8, self.team );
        objective_setzoffset( var8, 32 );
        function_0442( var8, 1 );
        self.ref_11f64 = var8;
    }
    
    thread quest_circle_animate( self.semtex_stuckplayer.origin, self.“=
z‘¯<«1a5;[ 0 ], 2 );
}

// Params 0
// Size: 0x8e
function quest_circle_tick()
{
    self.ºá-õØZ'cV¾Íè¬8++;
    
    if ( self.ºá-õØZ'cV¾Íè¬8 + 1 < self.“=
z‘¯<«1a5;.size )
    {
        thread quest_circle_animate( self.“=
z‘¯<«1a5;[ self.ºá-õØZ'cV¾Íè¬8 - 1 ], self.“=
z‘¯<«1a5;[ self.ºá-õØZ'cV¾Íè¬8 ], 2 );
        self.›JïH}pàQ¦SÎ×‹% = self.“=
z‘¯<«1a5;[ self.ºá-õØZ'cV¾Íè¬8 + 1 ];
        self.„ë‚ş €—SQ¥PM÷Àñ«#k>Ğ = squared( self.›JïH}pàQ¦SÎ×‹%[ 2 ] );
        
        if ( self.ºá-õØZ'cV¾Íè¬8 == self.“=
z‘¯<«1a5;.size - 2 )
        {
            level thread scripts\mp\gametypes\br_public::dmztut_luicallback( "mission_blm_kiosk_nearby", self.team, 1, 1 );
            return;
        }
        
        return;
    }
    
    show_kiosk();
}

// Params 4
// Size: 0x9f
function quest_circle_animate( var0, var1, var2, var3 )
{
    self notify( "stop_circle_anim" );
    level endon( "game_ended" );
    self endon( "marked_to_remove" );
    self endon( "stop_circle_anim" );
    var4 = var2 * 1000;
    var5 = gettime() + var4;
    var6 = 0;
    self.“ù{˜©ë¥lÛ7ë¶Şì¬N moveto( ( var1[ 0 ], var1[ 1 ], self.´L¸èã:.origin[ 2 ] ), var2 );
    
    while ( var6 < 1 )
    {
        var6 = 1 - ( var5 - gettime() ) / var4;
        var7 = vectorlerp( var0, var1, var6 );
        var8 = var7;
        
        if ( istrue( var3 ) )
        {
            var8 = ( var7[ 0 ], var7[ 1 ], scripts\engine\math::lerp( var0[ 2 ], 0, var6 ) );
        }
        
        scripts\mp\gametypes\br_quest_util::ref_11dae( var8 );
        waitframe();
    }
}

// Params 0
// Size: 0x2
function __kiosk()
{
    
}

// Params 6
// Size: 0x123, Type: bool
function redacted_weapon_purchase( var0, var1, var2, var3, var4, var5 )
{
    if ( var0 calloutmarkerping_entityzoffset( "ui_br_purchase_file_override" ) == 8 )
    {
        var0 reportchallengeuserevent( "collect_item", "dragons_den_blackmarket" );
    }
    
    if ( istrue( var5 ) )
    {
        var0 scripts\mp\gametypes\br_pickups::minsteps( var1, var3, var4, var5 );
        return true;
    }
    
    var6 = spawnstruct();
    var6.scriptablename = var1;
    var6.origin = var0.origin + ( 0, 0, 12 );
    var6.count = 0;
    var6.maxcount = level.br_pickups.maxcounts[ var6.scriptablename ];
    var6.stackable = level.br_pickups.stackable[ var6.scriptablename ];
    var6.impulsefx = 0;
    
    if ( isdefined( var3 ) )
    {
        var6.count = var3;
    }
    
    if ( !var6.count && isdefined( level.br_pickups.counts[ var6.scriptablename ] ) )
    {
        var6.count = level.br_pickups.counts[ var6.scriptablename ];
    }
    
    var7 = var0 scripts\mp\gametypes\br_pickups::cantakepickup( var6 );
    
    if ( var7 == 1 )
    {
        thread redacted_weapon_give_ammo_on_pickup();
        var0 scripts\mp\gametypes\br_pickups::onusecompleted( var6, var2, undefined, var4 );
        return true;
    }
    
    return false;
}

// Params 0
// Size: 0x7b
function redacted_weapon_give_ammo_on_pickup()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self waittill( "pickedupweapon", var0, var1 );
    
    switch ( var1.basename )
    {
        case "s4_mg_mgolf42_mp":
        case "s4_mr_moscar_mp":
        case "s4_sh_bromeo5_mp":
        case "s4_sm_owhiskey_mp":
        case "s4_ar_asierra44_mp":
            self givemaxammo( var1 );
            break;
        case "iw8_lm_dblmg_mp":
            self setweaponammoclip( var1, weaponclipsize( var1 ) );
            level thread _luidecision::getsquadspawnlocations( self, var1, weaponclipsize( var1 ) );
            break;
    }
}

