
// Params 0
// Size: 0x96
function init()
{
    var0 = spawnstruct();
    var0.weight = getdvarfloat( "scr_br_pe_auavscan_weight", 0 );
    var0.ref_140cf = &ref_140cf;
    var0.attackerswaittime = &attackerswaittime;
    var0.ref_14382 = &ref_14382;
    var0.‹Á¿ø{ÏXX;â# / = &postinitfunc;
    var0.ref_11b78 = getdvarint( "scr_br_pe_auavscan_max_times", 1 );
    var0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx( "auavscan", "20   20  15  15          10  10  10  10" );
    var0.£¼#w]j‹ƒ½Ï‚UÀíÌI¸Û« = scripts\mp\gametypes\br_publicevents_meter::getdvarpemetereventweights( "auavscan" );
    scripts\mp\gametypes\br_publicevents::ref_12b35( 10, var0 );
    scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback( &onplayerspawned );
}

// Params 0
// Size: 0xd7
function postinitfunc()
{
    game[ "dialog" ][ "pe_auavscan_announcement" ] = "public_events_ocscn_name";
    game[ "dialog" ][ "pe_auavscan_scan_imminent" ] = "public_events_scan_imminent";
    game[ "dialog" ][ "pe_auavscan_scan_now" ] = "public_events_scan_now";
    game[ "dialog" ][ "pe_auavscan_scan_end" ] = "public_events_scan_end";
    game[ "dialog" ][ "pe_auavscan_stay_prone" ] = "public_events_ocscn_stay_prone";
    game[ "dialog" ][ "pe_auavscan_spotted" ] = "public_events_ocscn_spotted";
    game[ "dialog" ][ "pe_auavscan_scan_complete" ] = "public_events_scan_complete";
    game[ "dialog" ][ "pe_auavscan_enemy_exposed" ] = "public_events_ocscn_enemy_exposed";
    game[ "music" ][ "pe_auavscan_music_spotted" ] = [ "operation_scan_spotted_01", "operation_scan_spotted_02" ];
    game[ "music" ][ "pe_auavscan_music_not_spotted" ] = [ "operation_scan_not_spotted_01", "operation_scan_not_spotted_02" ];
    level.‚š‡Û¸{Ûè7•Ø0Ç@x‹¹˜W]` = 1;
}

// Params 0
// Size: 0x5, Type: bool
function ref_140cf()
{
    return true;
}

// Params 0
// Size: 0x18
function ref_14382()
{
    level endon( "game_ended" );
    level endon( "cancel_public_event" );
    var0 = forest_combat();
    wait var0;
}

// Params 0
// Size: 0x30
function forest_combat()
{
    var0 = getdvarfloat( "scr_br_pe_auavscan_starttime_min", 60 );
    var1 = getdvarfloat( "scr_br_pe_auavscan_starttime_max", 565 );
    
    if ( var1 > var0 )
    {
        return randomfloatrange( var0, var1 );
    }
    
    return var0;
}

// Params 0
// Size: 0x96
function attackerswaittime()
{
    level endon( "game_ended" );
    
    if ( !istrue( level.‚š‡Û¸{Ûè7•Ø0Ç@x‹¹˜W]` ) || !isdefined( game[ "dialog" ][ "pe_auavscan_scan_now" ] ) )
    {
        var0 = getdvarfloat( "scr_br_pe_auavscan_weight", -1 );
        
        if ( var0 < 0 )
        {
            var0 = "unset";
        }
        
        var1 = 0;
        scripts\mp\utility\script::laststand_dogtags( "auavscan being activated without dialog data, event dvar weight [" + var0 + "], default weight [" + var1 + "], postInitFunc ran [" + istrue( level.‚š‡Û¸{Ûè7•Ø0Ç@x‹¹˜W]` ) + "]" );
        return;
    }
    
    delayeventtominstarttime();
    level.«ˆÊë,W,gÍ±X›}æà{£ÑV2úÁc¼+9› = [];
    scripts\mp\gametypes\br_publicevents::ref_13371( "br_pe_auavscan_incoming" );
    scripts\mp\gametypes\br_public::brleaderdialog( "pe_auavscan_announcement" );
    wait 3.5;
    thread scananticipation();
}

// Params 0
// Size: 0x3b
function delayeventtominstarttime()
{
    if ( isdefined( level.starttimefrommatchstart ) )
    {
        var0 = getdvarfloat( "scr_br_pe_auavscan_starttime_min", 60 ) * 1000 + level.starttimefrommatchstart;
        
        if ( var0 > gettime() )
        {
            var1 = ( var0 - gettime() ) / 1000;
            wait var1;
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x117
function scananticipation()
{
    level endon( "game_ended" );
    var0 = getdvarfloat( "scr_br_pe_auavscan_anticipation_duration", 12.5 );
    var1 = getdvarfloat( "scr_br_pe_auavscan_radar_duration", 20 );
    var2 = getdvarfloat( "scr_br_pe_auavscan_prone_duration", 5 );
    var3 = gettime() + var0 * 1000;
    thread setupclocktick( var0 );
    thread scripts\mp\gametypes\br_public::brleaderdialog( "pe_auavscan_scan_imminent" );
    setomnvar( "ui_publicevent_timer_type", 6 );
    setomnvar( "ui_publicevent_timer", var3 );
    setomnvar( "ui_publicevent_minimap_pulse", 1 );
    thread warnstandingplayers( var0 );
    thread excludeunavailableplayers( var0 );
    
    if ( isdefined( var0 ) )
    {
        wait var0;
    }
    
    var4 = gettime() + var2 * 1000;
    setomnvar( "ui_publicevent_timer_type", 10 );
    setomnvar( "ui_publicevent_timer", var4 );
    
    foreach ( var6 in level.players )
    {
        if ( !istrue( isplayeravailableforevent( var6 ) ) )
        {
            continue;
        }
        
        var6.™Á©°CÏY £ês§‡i[{·8 = 1;
        thread radaractive();
        
        if ( var6 getstance() == "prone" )
        {
            thread scanactive( var6 );
            continue;
        }
        
        thread spottedbyauavscan();
    }
    
    manageauavscanend( var2, var1 );
}

// Params 1
// Size: 0x41
function scanactive( var0 )
{
    level endon( "game_ended" );
    level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "pe_auavscan_stay_prone", self, 1, 0 );
    thread playscanbink( "pe_auavscan_timer", 1 );
    thread watchplayerdetection( var0 );
    thread watchweaponfired( var0 );
    self setclientomnvar( "ui_publicevent_auavscan_spotted", 0 );
}

// Params 0
// Size: 0x19
function radaractive()
{
    level endon( "game_ended" );
    self playsoundtoplayer( "ui_operation_scan_active_lr", self );
    setauavradar();
}

// Params 2
// Size: 0x3b
function manageauavscanend( var0, var1 )
{
    wait var0;
    scanend();
    
    if ( level.«ˆÊë,W,gÍ±X›}æà{£ÑV2úÁc¼+9›.size == 0 )
    {
        thread scripts\mp\gametypes\br_public::brleaderdialog( "pe_auavscan_scan_complete" );
        radarend();
        return;
    }
    
    wait var1;
    thread scripts\mp\gametypes\br_public::brleaderdialog( "pe_auavscan_scan_end" );
    radarend();
}

// Params 0
// Size: 0x7c
function scanend()
{
    level notify( "public_event_auavscan_prone_phase_ended" );
    setomnvar( "ui_publicevent_minimap_pulse", 0 );
    setomnvar( "ui_publicevent_timer_type", 0 );
    var0 = level.players.size;
    
    foreach ( var2 in level.players )
    {
        if ( !isdefined( var2 ) )
        {
            var0--;
            continue;
        }
        
        if ( istrue( var2.†x«Ò#Ï(/Í_š‡}
ýÑ3†‰f  ) )
        {
            var0--;
        }
        
        playerscanend( var2 );
    }
    
    branalytics_pe_auavscan( var0, level.«ˆÊë,W,gÍ±X›}æà{£ÑV2úÁc¼+9›.size );
}

// Params 0
// Size: 0xd1
function playerscanend()
{
    if ( !istrue( self.„3°K!—’È(ú«ÃÃ×K‡p ) )
    {
        self notify( "pe_auavscan_player_unspotted" );
        
        if ( isalive( self ) && !istrue( scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() ) && istrue( self.™Á©°CÏY £ês§‡i[{·8 ) )
        {
            thread scripts\mp\utility\points::giveunifiedpoints( "br_pe_auavscan_unspotted" );
            var0 = game[ "music" ][ "pe_auavscan_music_not_spotted" ].size;
            var1 = randomint( var0 );
            self setplayermusicstate( game[ "music" ][ "pe_auavscan_music_not_spotted" ][ var1 ] );
        }
    }
    
    if ( !istrue( self.†x«Ò#Ï(/Í_š‡}
ýÑ3†‰f  ) && level.«ˆÊë,W,gÍ±X›}æà{£ÑV2úÁc¼+9›.size > 0 )
    {
        var2 = undefined;
        
        foreach ( var4 in level.«ˆÊë,W,gÍ±X›}æà{£ÑV2úÁc¼+9› )
        {
            if ( var4.team != self.team )
            {
                var2 = 1;
                break;
            }
        }
        
        if ( istrue( var2 ) )
        {
            level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "pe_auavscan_enemy_exposed", self, 1, 0 );
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x3e
function radarend()
{
    level.ˆ¾èé{•À£ð¶ƒPŸ©w‹‹û = undefined;
    
    foreach ( var1 in level.players )
    {
        if ( !isdefined( var1 ) )
        {
            continue;
        }
        
        playerradarend( var1 );
    }
}

// Params 0
// Size: 0x3e
function playerradarend()
{
    self notify( "pe_auavscan_end" );
    self startragdollfromvehiclehit( 0 );
    self setplayeradvanceduavdot( 0 );
    self sethidenameplate( 0 );
    self.„3°K!—’È(ú«ÃÃ×K‡p = undefined;
    self.™Á©°CÏY £ês§‡i[{·8 = undefined;
    self.†x«Ò#Ï(/Í_š‡}
ýÑ3†‰f  = undefined;
    self setclientomnvar( "ui_publicevent_auavscan_spotted", 0 );
    resetradar();
}

// Params 1
// Size: 0x4a
function watchplayerdetection( var0 )
{
    level endon( "game_ended" );
    level endon( "public_event_auavscan_prone_phase_ended" );
    self endon( "death_or_disconnect" );
    self startragdollfromvehiclehit( 1 );
    self sethidenameplate( 0 );
    
    while ( var0 > gettime() )
    {
        if ( self getstance() != "prone" )
        {
            thread spottedbyauavscan();
            break;
        }
        
        waitframe();
    }
}

// Params 1
// Size: 0x78
function watchweaponfired( var0 )
{
    level endon( "game_ended" );
    level endon( "public_event_auavscan_prone_phase_ended" );
    self endon( "pe_auavscan_player_spotted" );
    self endon( "death_or_disconnect" );
    
    while ( var0 > gettime() )
    {
        self waittill( "weapon_fired", var1 );
        
        if ( istrue( self.„3°K!—’È(ú«ÃÃ×K‡p ) )
        {
            break;
        }
        
        if ( scripts\mp\class::vehicle_checkpiggybackexploit( var1 ) )
        {
            continue;
        }
        
        self startragdollfromvehiclehit( 0 );
        self setplayeradvanceduavdot( 1 );
        wait 5;
        self setplayeradvanceduavdot( 0 );
        self startragdollfromvehiclehit( !istrue( self.„3°K!—’È(ú«ÃÃ×K‡p ) );
    }
}

// Params 0
// Size: 0x35
function onplayerspawned()
{
    if ( istrue( level.ˆ¾èé{•À£ð¶ƒPŸ©w‹‹û ) )
    {
        excludeplayer();
        resetradar();
        self startragdollfromvehiclehit( 1 );
        self sethidenameplate( 0 );
        self setplayeradvanceduavdot( 0 );
        self.„3°K!—’È(ú«ÃÃ×K‡p = undefined;
        self.™Á©°CÏY £ês§‡i[{·8 = undefined;
        return;
    }
}

// Params 1
// Size: 0x7c
function warnstandingplayers( var0 )
{
    level endon( "game_ended" );
    var1 = getdvarfloat( "scr_br_pe_auavscan_warning_time", 3 );
    
    if ( isdefined( var0 ) && var0 >= var1 )
    {
        var2 = var0 - var1;
        wait var2;
        
        foreach ( var4 in level.players )
        {
            if ( !istrue( isplayeravailableforevent( var4 ) ) || var4 getstance() == "prone" )
            {
                continue;
            }
            
            level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "pe_auavscan_scan_now", var4, 1, 0 );
        }
        
        return;
    }
}

// Params 1
// Size: 0x7c
function excludeunavailableplayers( var0 )
{
    level endon( "game_ended" );
    var1 = getdvarfloat( "scr_br_pe_auavscan_exclude_respawn_threshold", 5 );
    
    if ( isdefined( var0 ) && var0 >= var1 )
    {
        var2 = var0 - var1;
        wait var2;
    }
    
    level.ˆ¾èé{•À£ð¶ƒPŸ©w‹‹û = 1;
    
    foreach ( var4 in level.players )
    {
        if ( isdefined( var4 ) && isalive( var4 ) && !var4 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() )
        {
            continue;
        }
        
        excludeplayer( var4 );
    }
}

// Params 0
// Size: 0x15
function excludeplayer()
{
    self.†x«Ò#Ï(/Í_š‡}
ýÑ3†‰f  = 1;
    self setclientomnvar( "ui_publicevent_auavscan_spotted", -1 );
}

// Params 0
// Size: 0x1e, Type: bool
function isplayeravailableforevent()
{
    return isdefined( self ) && isalive( self ) && !scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() && !istrue( self.†x«Ò#Ï(/Í_š‡}
ýÑ3†‰f  );
}

// Params 0
// Size: 0xb2
function spottedbyauavscan()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self notify( "pe_auavscan_player_spotted" );
    level.«ˆÊë,W,gÍ±X›}æà{£ÑV2úÁc¼+9›[ level.«ˆÊë,W,gÍ±X›}æà{£ÑV2úÁc¼+9›.size ] = self;
    self.„3°K!—’È(ú«ÃÃ×K‡p = 1;
    self setclientomnvar( "ui_publicevent_auavscan_spotted", 1 );
    scripts\mp\hud_message::showsplash( "br_pe_auavscan_spotted" );
    level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "pe_auavscan_spotted", self );
    self setplayeradvanceduavdot( 0 );
    self startragdollfromvehiclehit( 0 );
    self sethidenameplate( 1 );
    thread spottedmarkflash();
    wait 0.25;
    thread playscanbink( "pe_auavscan_spotted", 1 );
    var0 = game[ "music" ][ "pe_auavscan_music_spotted" ].size;
    var1 = randomint( var0 );
    self setplayermusicstate( game[ "music" ][ "pe_auavscan_music_spotted" ][ var1 ] );
    self playsoundtoplayer( "sfx_occupation_scan_spotted_flash", self );
}

// Params 0
// Size: 0x3a
function spottedmarkflash()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    
    if ( !istrue( self.iszombie ) )
    {
        self visionsetnakedforplayer( "pe_auavscan_flash", 0.075 );
        wait 0.1;
        scripts\mp\utility\player::restorebasevisionset( 2.5 );
        return;
    }
}

// Params 2
// Size: 0x72
function playscanbink( var0, var1 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self setclientomnvar( "ui_br_bink_overlay_state", 14 );
    level.•z!ƒcæú ó»‡3™ìˆâ€{ßkcé = 1;
    thread watchdronereconuse();
    
    if ( istrue( var1 ) )
    {
        self stopcinematicforplayer( var0 );
    }
    else
    {
        self preloadcinematicforplayer( var0 );
    }
    
    scripts\engine\utility::ref_143a7( "pe_auavscan_end", "pe_auavscan_player_spotted", "pe_auavscan_player_unspotted", "death_or_disconnect" );
    self skydive_cutparachuteoff();
    self setclientomnvar( "ui_br_bink_overlay_state", 0 );
    level.•z!ƒcæú ó»‡3™ìˆâ€{ßkcé = 0;
}

// Params 0
// Size: 0x85
function watchdronereconuse()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "pe_auavscan_end" );
    self endon( "pe_auavscan_player_spotted" );
    self endon( "pe_auavscan_player_unspotted" );
    
    while ( level.•z!ƒcæú ó»‡3™ìˆâ€{ßkcé )
    {
        var0 = self calloutmarkerping_entityzoffset( "ui_rcd_controls" ) > 0;
        
        if ( !var0 )
        {
            var1 = 0;
            
            while ( var1 == 0 )
            {
                self waittill( "omnvar_ui_rcd_changed", var1 );
            }
        }
        
        self setclientomnvar( "ui_br_bink_overlay_state", 0 );
        self waittillmatch( "omnvar_ui_rcd_changed", 0 );
        
        if ( istrue( level.•z!ƒcæú ó»‡3™ìˆâ€{ßkcé ) )
        {
            self setclientomnvar( "ui_br_bink_overlay_state", 14 );
        }
    }
}

// Params 0
// Size: 0x29
function setauavradar()
{
    var0 = level.ref_13ed9;
    var1 = "constant_radar";
    var2 = 1;
    var3 = 1;
    attackerregenammo( var1, var0, var2, var3 );
    self.hasradar = 1;
}

// Params 0
// Size: 0x23
function resetradar()
{
    var0 = 1;
    var1 = "normal_radar";
    var2 = 0;
    var3 = undefined;
    attackerregenammo( var1, var0, var2, var3 );
    self.hasradar = 0;
}

// Params 4
// Size: 0x53
function attackerregenammo( var0, var1, var2, var3 )
{
    var4 = var1;
    level.radarmode[ self.guid ] = var0;
    self.radarstrength = var4;
    level.activeuavs[ self.guid + "_radarStrength" ] = var4;
    level.activeadvanceduavs[ self.guid ] = var2;
    self.ref_133e9 = var3;
    level.audio_heli_end_fade_out = level.teamnamelist.size;
    scripts\cp_mp\killstreaks\uav::updateplayersuavstatus();
}

// Params 1
// Size: 0x45
function setupclocktick( var0 )
{
    level endon( "game_ended" );
    var1 = spawn( "script_origin", ( 0, 0, 0 ) );
    var1 hide();
    
    if ( var0 >= 13 )
    {
        wait var0 - 13;
    }
    
    var1 playsound( "sfx_occupation_pre_scan_timer" );
    wait 13;
    var1 delete();
}

// Params 2
// Size: 0x2e
function branalytics_pe_auavscan( var0, var1 )
{
    var2 = [];
    GscBinSkip0( 0x2e, var2.size, "available_players_count" );
    // Unknown operator ( 0x2e, iw8, PC )
}

