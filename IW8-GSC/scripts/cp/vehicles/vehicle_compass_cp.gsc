
// Params 0
// Size: 0x94
function init()
{
    level.ismountdisabled = getdvarint( "debug_challenges", 0 ) != 0;
    level.play_intel_collect_vo = getdvarint( "OLPQMTTQR", 1 ) != 0;
    level.getallactivequestsforteam = getdvarint( "LRTSSKLKPK", 1 );
    
    if ( !challengesenabled() )
    {
        return;
    }
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "getGameType" ) )
    {
        var0 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "getGameType" ) ]]();
        
        if ( isdefined( var0 ) && ( var0 == "br" || var0 == "brtdm" ) )
        {
            level.getattractionomnvarbitpackinginfo = 1;
            setupchallengelocales( level );
            thread ref_13c45();
            ref_13223();
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x5c
function ref_13223()
{
    var0 = [];
    GscBinSkip0( 0x2e, "sprintout_sh_t9semiauto01", 1 );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 1
// Size: 0x46, Type: bool
function turn_on_have_target_hud( var0 )
{
    var1 = var0;
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "getWeaponRootName" ) )
    {
        var1 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "getWeaponRootName" ) ]]( var0 );
    }
    
    if ( isdefined( level.ref_14580 ) && istrue( level.ref_14580[ var1 ] ) )
    {
        return true;
    }
    
    return false;
}

// Params 0
// Size: 0xcf
function setupchallengelocales()
{
    var0 = getdvar( "map_for_poi_nameset", level.mapname );
    level.‹Ò;‰PEÓÕ *(?[ü = 0;
    
    switch ( var0 )
    {
        case "mp_escape4":
        case "mp_escape3":
            level.‹Ò;‰PEÓÕ *(?[ü = 2;
            ref_11ad7();
            break;
        case "mp_don4_pm":
        case "mp_don3_ch2":
        case "mp_don3":
        case "mp_don4":
            level.‹Ò;‰PEÓÕ *(?[ü = 1;
            ref_11adb();
            break;
        case "mp_wz_island":
            level.‹Ò;‰PEÓÕ *(?[ü = 3;
            ref_11ad9();
            break;
        case "mp_sm_island_1":
            level.‹Ò;‰PEÓÕ *(?[ü = 4;
            mapchallengelocalesfortuneskeep();
            break;
        case "mp_br_mechanics":
            ref_11adb();
            ref_11ad7();
            ref_11ad9();
            mapchallengelocalesfortuneskeep();
            break;
        default:
            ref_11ad8( var0 );
            break;
    }
}

// Params 0
// Size: 0x13
function getchallengemapid()
{
    if ( isdefined( level.‹Ò;‰PEÓÕ *(?[ü ) )
    {
        return level.‹Ò;‰PEÓÕ *(?[ü;
    }
    
    return 0;
}

// Params 0
// Size: 0x39a
function ref_11adb()
{
    level.localetriggers = [];
    var0 = getentarray( "location_volume", "targetname" );
    
    if ( isdefined( var0 ) && var0.size > 0 )
    {
        foreach ( var2 in var0 )
        {
            if ( !isdefined( var2.script_noteworthy ) )
            {
                continue;
            }
            
            switch ( var2.script_noteworthy )
            {
                case "airfield":
                    var2.localeid = 1;
                    break;
                case "boneyard":
                    var2.localeid = 2;
                    break;
                case "coast":
                    var2.localeid = 3;
                    break;
                case "dam":
                case "summit":
                    var2.localeid = 4;
                    break;
                case "downtown":
                    var2.localeid = 5;
                    break;
                case "farms":
                    var2.localeid = 6;
                    break;
                case "gulag":
                    var2.localeid = 7;
                    break;
                case "hospital":
                    var2.localeid = 8;
                    break;
                case "junkyard":
                    var2.localeid = 9;
                    break;
                case "layover":
                    var2.localeid = 10;
                    break;
                case "lumber":
                    var2.localeid = 11;
                    break;
                case "maintenance":
                    var2.localeid = 12;
                    break;
                case "outskirts":
                    var2.localeid = 13;
                    break;
                case "park":
                    var2.localeid = 14;
                    break;
                case "port":
                    var2.localeid = 15;
                    break;
                case "salt_mine":
                case "quarry":
                    var2.localeid = 16;
                    break;
                case "river_east":
                    var2.localeid = 17;
                    break;
                case "river_north":
                    var2.localeid = 18;
                    break;
                case "river_south":
                    var2.localeid = 19;
                    break;
                case "stadium":
                    var2.localeid = 20;
                    break;
                case "storagetown":
                    var2.localeid = 21;
                    break;
                case "suburbs_airfield":
                    var2.localeid = 22;
                    break;
                case "suburbs_coast":
                    var2.localeid = 23;
                    break;
                case "suburbs_dam":
                    var2.localeid = 24;
                    break;
                case "suburbs_eastriver":
                    var2.localeid = 25;
                    break;
                case "suburbs_hospital":
                    var2.localeid = 26;
                    break;
                case "suburbs_quarry":
                    var2.localeid = 27;
                    break;
                case "suburbs_stadium":
                    var2.localeid = 28;
                    break;
                case "suburbs_super":
                    var2.localeid = 29;
                    break;
                case "suburbs_transit":
                    var2.localeid = 30;
                    break;
                case "super":
                    var2.localeid = 31;
                    break;
                case "transit":
                    var2.localeid = 32;
                    break;
                case "tvstation":
                    var2.localeid = 33;
                    break;
                case "hills":
                    var2.localeid = 34;
                    break;
                case "shopping_district_w":
                case "shopping_district_e":
                    var2.localeid = 35;
                    break;
                default:
                    ref_11ad6( var2.script_noteworthy );
                    break;
            }
        }
        
        level.localetriggers = var0;
        return;
    }
}

// Params 0
// Size: 0x1f9
function ref_11ad9()
{
    level.localetriggers = [];
    var0 = getentarray( "location_volume", "targetname" );
    
    if ( isdefined( var0 ) && var0.size > 0 )
    {
        foreach ( var2 in var0 )
        {
            if ( !isdefined( var2.script_noteworthy ) )
            {
                continue;
            }
            
            switch ( var2.script_noteworthy )
            {
                case "airfield":
                    var2.localeid = 36;
                    break;
                case "airstrip":
                    var2.localeid = 37;
                    break;
                case "arsenal":
                    var2.localeid = 38;
                    break;
                case "beachhead":
                    var2.localeid = 39;
                    break;
                case "caldera":
                    var2.localeid = 40;
                    break;
                case "capital":
                    var2.localeid = 41;
                    break;
                case "docks":
                    var2.localeid = 42;
                    break;
                case "farms":
                    var2.localeid = 43;
                    break;
                case "lagoon":
                    var2.localeid = 44;
                    break;
                case "mines":
                    var2.localeid = 45;
                    break;
                case "powerplant":
                    var2.localeid = 46;
                    break;
                case "resort":
                    var2.localeid = 47;
                    break;
                case "ruins":
                    var2.localeid = 48;
                    break;
                case "subpen":
                    var2.localeid = 49;
                    break;
                case "village":
                    var2.localeid = 50;
                    break;
                case "storagetown":
                    var2.localeid = 62;
                    break;
                case "chem_factory":
                    var2.localeid = 63;
                    break;
                default:
                    ref_11ad6( var2.script_noteworthy );
                    break;
            }
        }
        
        level.localetriggers = var0;
        return;
    }
}

// Params 0
// Size: 0x175
function ref_11ad7()
{
    level.localetriggers = [];
    var0 = getentarray( "location_volume", "targetname" );
    
    if ( isdefined( var0 ) && var0.size > 0 )
    {
        foreach ( var2 in var0 )
        {
            if ( !isdefined( var2.script_noteworthy ) )
            {
                continue;
            }
            
            switch ( var2.script_noteworthy )
            {
                case "biolab":
                    var2.localeid = 51;
                    break;
                case "chemplant":
                    var2.localeid = 52;
                    break;
                case "commstower":
                    var2.localeid = 53;
                    break;
                case "control":
                    var2.localeid = 54;
                    break;
                case "deconfacility":
                    var2.localeid = 55;
                    break;
                case "factory":
                    var2.localeid = 56;
                    break;
                case "harbor":
                    var2.localeid = 57;
                    break;
                case "headquarters":
                    var2.localeid = 58;
                    break;
                case "qblock":
                    var2.localeid = 59;
                    break;
                case "residence":
                    var2.localeid = 60;
                    break;
                case "shore":
                    var2.localeid = 61;
                    break;
                default:
                    ref_11ad6( var2.script_noteworthy );
                    break;
            }
        }
        
        level.localetriggers = var0;
        return;
    }
}

// Params 0
// Size: 0x267
function mapchallengelocalesfortuneskeep()
{
    level.localetriggers = [];
    var0 = getentarray( "location_volume", "targetname" );
    
    if ( isdefined( var0 ) && var0.size > 0 )
    {
        foreach ( var2 in var0 )
        {
            if ( !isdefined( var2.script_noteworthy ) )
            {
                continue;
            }
            
            switch ( var2.script_noteworthy )
            {
                case "coast":
                    var2.localeid = 64;
                    break;
                case "beach":
                    var2.localeid = 65;
                    break;
                case "graveyard":
                    var2.localeid = 66;
                    break;
                case "town_square":
                    var2.localeid = 67;
                    break;
                case "overlook":
                    var2.localeid = 68;
                    break;
                case "town_outskirts":
                    var2.localeid = 69;
                    break;
                case "cenote_top":
                    var2.localeid = 70;
                    break;
                case "cenote_bottom":
                    var2.localeid = 71;
                    break;
                case "radio_station":
                    var2.localeid = 72;
                    break;
                case "smugglers_bay":
                    var2.localeid = 73;
                    break;
                case "lighthouse":
                    var2.localeid = 74;
                    break;
                case "airfield":
                    var2.localeid = 75;
                    break;
                case "beach_east":
                    var2.localeid = 76;
                    break;
                case "cove":
                    var2.localeid = 77;
                    break;
                case "winery":
                    var2.localeid = 78;
                    break;
                case "fort_east":
                    var2.localeid = 79;
                    break;
                case "fort_south":
                    var2.localeid = 80;
                    break;
                case "fort_west":
                    var2.localeid = 81;
                    break;
                case "fort_keep":
                    var2.localeid = 82;
                    break;
                case "church":
                    var2.localeid = 83;
                    break;
                case "gardens":
                    var2.localeid = 84;
                    break;
                case "smuggler_camp":
                    var2.localeid = 85;
                    break;
                default:
                    ref_11ad6( var2.script_noteworthy );
                    break;
            }
        }
        
        level.localetriggers = var0;
        return;
    }
}

// Params 1
// Size: 0x2e
function ref_11ad8( var0 )
{
    if ( var0 == "mp_br_mechanics" || var0 == "mp_vg_mechanics" || var0 == "mp_firingrange" || var0 == "mp_hmsisle_test" )
    {
        return;
    }
}

// Params 1
// Size: 0x5
function ref_11ad6( var0 )
{
    
}

// Params 0
// Size: 0x8
function challengesenabled()
{
    return level.challengesallowed;
}

// Params 0
// Size: 0x2b, Type: bool
function challengesenabledforplayer()
{
    if ( !challengesenabled() )
    {
        return false;
    }
    
    if ( !isplayer( self ) || isai( self ) )
    {
        return false;
    }
    
    if ( istrue( level.getarenapickupattachmentoverrides ) )
    {
        return false;
    }
    
    return true;
}

// Params 0
// Size: 0x166
function relic_amped_is_there_valid_new_victim()
{
    var0 = undefined;
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "getGameType" ) )
    {
        var0 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "getGameType" ) ]]();
    }
    
    if ( !isdefined( var0 ) )
    {
        var0 = getdvar( "NKTMKRMSKR" );
    }
    
    if ( !isdefined( var0 ) )
    {
        return 0;
    }
    
    if ( !isdefined( level.getallselectableattachments ) || !isdefined( level.getallselectableattachments.game_type_col ) || !isdefined( level.getallselectableattachments.game_type_col[ var0 ] ) )
    {
        return 0;
    }
    
    if ( var0 == "br" )
    {
        if ( getdvarint( "enable_rebirth_gamemodes_shared_id", 0 ) && scripts\cp_mp\utility\game_utility::turretdisabled() )
        {
            return 95;
        }
        
        var1 = "";
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "getSubGameType" ) )
        {
            var1 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "getSubGameType" ) ]]();
        }
        
        switch ( var1 )
        {
            case "rat_race":
            case "dmz":
                return 99;
            case "extract":
                return 98;
            case "evac":
                return 97;
            case "sandbox":
                return 96;
            case "olaride":
            case "rebirth_dbd_reverse":
            case "rebirth_dbd":
            case "rebirth_reverse":
            case "rebirth":
                return 95;
            case "payload":
                return 94;
            case "mendota":
                return 93;
            case "gold_war":
                return 92;
            case "tdbd":
                return 91;
            case "br":
                break;
            default:
                break;
        }
    }
    
    return level.getallselectableattachments.game_type_col[ var0 ];
}

// Params 0
// Size: 0x19, Type: bool
function getatvspawns()
{
    if ( !istrue( level.getattractionomnvarbitpackinginfo ) )
    {
        return false;
    }
    
    if ( !challengesenabledforplayer() )
    {
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0x1f, Type: bool
function ref_140db( var0 )
{
    if ( !isdefined( self.getattachmentoverride ) )
    {
        return false;
    }
    
    if ( !isdefined( self.getattachmentoverride[ var0 ] ) )
    {
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0x1f
function ref_12c6e( var0 )
{
    if ( !getatvspawns() )
    {
        return;
    }
    
    if ( !ref_140db( var0 ) )
    {
        return;
    }
    
    self.getattachmentoverride[ var0 ] = 0;
}

// Params 1
// Size: 0x3a
function ref_1383b( var0 )
{
    if ( !getatvspawns() )
    {
        return;
    }
    
    if ( !isdefined( self.getattachmentoverride ) )
    {
        self.getattachmentoverride = [];
    }
    
    if ( !isdefined( self.getattachmentoverride[ var0 ] ) )
    {
        self.getattachmentoverride[ var0 ] = 0;
    }
    
    self.getattachmentoverride[ var0 ] = gettime();
}

// Params 1
// Size: 0x3d
function getchallengestatcacheamount( var0 )
{
    switch ( var0 )
    {
        case "totalDistTraveled":
            return getdvarint( "scr_challenge_cache_amount_totalDistTraveled", 63360 );
        case "totalDistTraveledByFoot":
            return getdvarint( "scr_challenge_cache_amount_totalDistTraveledByFoot", 19685 );
        default:
            return -1;
    }
}

// Params 2
// Size: 0x120
function reportchallengestatamount( var0, var1 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    if ( var1 <= 0 )
    {
        return;
    }
    
    var2 = "scr_challenge_killswitch_stat_" + var0;
    var3 = getdvarint( var2, 0 );
    
    if ( var3 > 0 )
    {
        return;
    }
    
    var4 = resetstuckthermite();
    var5 = relic_amped_is_there_valid_new_victim();
    
    switch ( var0 )
    {
        case "driving":
            self reportchallengeuserevent( "stats", var4, var5, var1, 0, 0, 0, 0, 0, 0 );
            break;
        case "alive_in_gas":
            self reportchallengeuserevent( "stats", var4, var5, 0, var1, 0, 0, 0, 0, 0 );
            break;
        case "alive_not_downed":
            self reportchallengeuserevent( "stats", var4, var5, 0, 0, var1, 0, 0, 0, 0 );
            break;
        case "totalDistTraveled":
            self reportchallengeuserevent( "stats", var4, var5, 0, 0, 0, var1, 0, 0, 0 );
            break;
        case "totalDistTraveledByFoot":
            self reportchallengeuserevent( "stats", var4, var5, 0, 0, 0, 0, var1, 0, 0 );
            break;
        case "spray":
            self reportchallengeuserevent( "stats", var4, var5, 0, 0, 0, 0, 0, var1, 0 );
            break;
        case "gesture":
            self reportchallengeuserevent( "stats", var4, var5, 0, 0, 0, 0, 0, 0, var1 );
            break;
    }
}

// Params 1
// Size: 0x47
function ref_138d5( var0 )
{
    if ( !getatvspawns() )
    {
        return;
    }
    
    if ( !ref_140db( var0 ) )
    {
        return;
    }
    
    if ( self.getattachmentoverride[ var0 ] > 0 )
    {
        var1 = gettime() - self.getattachmentoverride[ var0 ];
        
        if ( var1 > 0 )
        {
            reportchallengestatamount( var0, var1 );
        }
        
        self.getattachmentoverride[ var0 ] = 0;
        return;
    }
}

// Params 2
// Size: 0x4b
function getextractionpadent( var0, var1 )
{
    if ( !getatvspawns() )
    {
        return;
    }
    
    if ( !ref_140db( var0 ) )
    {
        return;
    }
    
    if ( self.getattachmentoverride[ var0 ] > 0 )
    {
        var2 = gettime() - self.getattachmentoverride[ var0 ];
        
        if ( var2 >= var1 )
        {
            reportchallengestatamount( var0, var2 );
            self.getattachmentoverride[ var0 ] = gettime();
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x53
function ref_13c45()
{
    level endon( "game_ended" );
    
    for ( ;; )
    {
        if ( isdefined( level.players ) )
        {
            var0 = level.players.size;
            
            for ( var1 = 0; var1 < var0 ; var1++ )
            {
                if ( isalive( level.players[ var1 ] ) )
                {
                    getextractionpadent( level.players[ var1 ], "driving", 60000 );
                }
            }
        }
        
        wait 1;
    }
}

// Params 1
// Size: 0x3f
function flushchallengestat( var0 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    if ( !isdefined( self.ŽYPÊ‰ØÏÔÝS¡q~¢Ø² ) )
    {
        return;
    }
    
    if ( !isdefined( self.ŽYPÊ‰ØÏÔÝS¡q~¢Ø²[ var0 ] ) )
    {
        return;
    }
    
    var1 = int( self.ŽYPÊ‰ØÏÔÝS¡q~¢Ø²[ var0 ] );
    self.ŽYPÊ‰ØÏÔÝS¡q~¢Ø²[ var0 ] = 0;
    reportchallengestatamount( var0, var1 );
}

// Params 2
// Size: 0x8e
function incchallengestat( var0, var1 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    if ( var1 <= 0 )
    {
        return;
    }
    
    if ( !isdefined( self.ŽYPÊ‰ØÏÔÝS¡q~¢Ø² ) )
    {
        self.ŽYPÊ‰ØÏÔÝS¡q~¢Ø² = [];
    }
    
    if ( !isdefined( self.ŽYPÊ‰ØÏÔÝS¡q~¢Ø²[ var0 ] ) )
    {
        self.ŽYPÊ‰ØÏÔÝS¡q~¢Ø²[ var0 ] = 0;
    }
    
    self.ŽYPÊ‰ØÏÔÝS¡q~¢Ø²[ var0 ] += var1;
    
    if ( self.ŽYPÊ‰ØÏÔÝS¡q~¢Ø²[ var0 ] <= 0 )
    {
        return;
    }
    
    var2 = getchallengestatcacheamount( var0 );
    
    if ( var2 < 0 )
    {
        return;
    }
    
    if ( self.ŽYPÊ‰ØÏÔÝS¡q~¢Ø²[ var0 ] >= var2 )
    {
        var3 = int( self.ŽYPÊ‰ØÏÔÝS¡q~¢Ø²[ var0 ] );
        self.ŽYPÊ‰ØÏÔÝS¡q~¢Ø²[ var0 ] = 0;
        reportchallengestatamount( var0, var3 );
        return;
    }
}

// Params 0
// Size: 0x20
function flushchallengestats()
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    flushchallengestat( "totalDistTraveled" );
    flushchallengestat( "totalDistTraveledByFoot" );
}

// Params 10
// Size: 0x9f
function onplayerkilled( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9 )
{
    if ( !challengesenabledforplayer( var1 ) )
    {
        return;
    }
    
    var10 = self;
    
    if ( !isplayer( var1 ) )
    {
        if ( isdefined( var0 ) && isplayer( var0 ) )
        {
            var1 = var0;
        }
        else
        {
            return;
        }
    }
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "player", "isFriendly" ) )
    {
        if ( ![[ scripts\cp_mp\utility\script_utility::getsharedfunc( "player", "isFriendly" ) ]]( var1.team, var10 ) )
        {
            if ( isdefined( var5.ref_121d9 ) )
            {
                var5 = var5.ref_121d9;
            }
            
            var11 = ref_14583( var5, var1 );
            init_sentry_traps( var0, var1, var11, var10, var7, var8, var5, var2, var4, var9 );
            return;
        }
        
        return;
    }
}

// Params 9
// Size: 0x5a
function ref_11ffc( var0, var1, var2, var3, var4, var5, var6, var7, var8 )
{
    if ( !challengesenabledforplayer( var1 ) )
    {
        return;
    }
    
    var9 = self;
    var10 = play_sound_from_closest_player( var9 );
    var11 = ref_14583( var5, var1 );
    
    if ( var10 == 2048 && level.getallactivequestsforteam == 8 )
    {
        thread ref_14010();
        chooseanim_arrival_forcode( var1, var10, var11[ 0 ], var7, var8, var0, var4 );
        return;
    }
}

// Params 2
// Size: 0x6d
function ref_12097( var0, var1 )
{
    if ( level.getallactivequestsforteam >= 10 )
    {
        if ( var0.staticdata.ref == "super_supply_drop" && !var1 )
        {
            ref_12c3f( "t9_ch_global_call_in_care_package_or_loadout_drops_for_operator_mission_s4", 1 );
        }
    }
    
    if ( level.getallactivequestsforteam >= 10 )
    {
        if ( var0.staticdata.ref == "super_supply_drop" && !var1 )
        {
            ref_12c3f( "t9_ch_global_call_in_care_package_or_loadout_drops_for_operator_mission_s5", 1 );
            return;
        }
        
        return;
    }
}

// Params 6
// Size: 0x1ab
function chooseanim_arrival_forcode( var0, var1, var2, var3, var4, var5 )
{
    var6 = "";
    var7 = 0;
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "equipment", "getEquipmentTableInfo" ) )
    {
        var8 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "equipment", "getEquipmentTableInfo" ) ]]( var1 );
        
        if ( isdefined( var8 ) )
        {
            var7 = var8.defaultslot == "primary";
        }
        else if ( var1 != "iav_weapon_mp" )
        {
            var6 = weaponclass( var1 );
        }
    }
    else if ( var1 != "iav_weapon_mp" )
    {
        var6 = weaponclass( var1 );
    }
    
    var9 = var5 == "MOD_CRUSH" && isdefined( var4 ) && isdefined( var4.vehiclename );
    
    if ( var2 & 1048576 )
    {
        ref_12c3f( "t9_ch_global_t9_wz_zm_critical_kills_for_event", 1 );
    }
    
    ref_12c3f( "t9_ch_global_t9_wz_zm_eliminations_for_event", 1 );
    
    if ( !isdefined( self.ref_146c8 ) )
    {
        self.ref_146c8 = 1;
    }
    else
    {
        self.ref_146c8++;
    }
    
    if ( istrue( var7 ) )
    {
        ref_12c3f( "t9_ch_global_t9_wz_zm_lethal_equipment_kills_for_event", 1 );
    }
    
    if ( istrue( var9 ) )
    {
        ref_12c3f( "t9_ch_global_t9_wz_zm_vehicle_eliminations_for_event", 1 );
    }
    
    if ( self.ref_146c8 >= 5 && !istrue( self.show_balloon_purchase_hint ) )
    {
        ref_12c3f( "t9_ch_global_t9_wz_zm_eliminations_per_game_for_event", 1 );
        self.show_balloon_purchase_hint = 1;
    }
    
    if ( var6 == "spread" )
    {
        ref_12c3f( "t9_ch_global_t9_wz_zm_shotgun_eliminations_for_event", 1 );
    }
    
    if ( isdefined( self.ref_12a8d ) && self.ref_12a8d == 2 )
    {
        ref_12c3f( "t9_ch_global_t9_wz_zm_multikills_for_event", 1 );
    }
    
    if ( var6 == "pistol" )
    {
        ref_12c3f( "t9_ch_global_t9_wz_zm_pistol_eliminations_for_event", 1 );
    }
    
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) && level.br_circle.circleindex == 0 )
    {
        ref_12c3f( "t9_ch_global_t9_wz_zm_eliminations_before_circle_for_event", 1 );
        return;
    }
}

// Params 0
// Size: 0x47
function ref_14010()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self notify( "updateRecentZombieKills" );
    self endon( "updateRecentZombieKills" );
    
    if ( !isdefined( self.ref_12a8d ) )
    {
        self.ref_12a8d = 1;
    }
    else
    {
        self.ref_12a8d++;
    }
    
    wait 4;
    self.ref_12a8d = 0;
}

// Params 5
// Size: 0x8d
function vehiclekilled( var0, var1, var2, var3, var4 )
{
    if ( !challengesenabledforplayer( var2 ) )
    {
        return;
    }
    
    var5 = var0;
    
    if ( isdefined( var4.ref_121d9 ) )
    {
        var4 = var4.ref_121d9;
    }
    
    var6 = ref_14583( var4, var2 );
    var7 = "MOD_UNKNOWN";
    var8 = 0;
    var9 = 0;
    var10 = 0;
    
    if ( isdefined( var2.modifiers ) )
    {
        var8 = var2.modifiers[ "mask" ];
        var9 = var2.modifiers[ "mask2" ];
        var10 = var2.modifiers[ "mask3" ];
    }
    
    init_sentry_traps( var1, var2, var6, var5, var8, var9, var4, var3, var7, var10 );
}

// Params 8
// Size: 0xd7
function equipmentdestroyed( var0, var1, var2, var3, var4, var5, var6, var7 )
{
    if ( !challengesenabledforplayer( var1 ) )
    {
        return;
    }
    
    var8 = self;
    
    if ( !isplayer( var1 ) )
    {
        if ( isdefined( var0 ) && isplayer( var0 ) )
        {
            var1 = var0;
        }
        else
        {
            return;
        }
    }
    
    if ( !isdefined( var8.owner ) )
    {
        return;
    }
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "player", "isFriendly" ) )
    {
        if ( ![[ scripts\cp_mp\utility\script_utility::getsharedfunc( "player", "isFriendly" ) ]]( var1.team, var8.owner ) )
        {
            if ( isdefined( var5.ref_121d9 ) )
            {
                var5 = var5.ref_121d9;
            }
            
            var9 = ref_14583( var5, var1 );
            var10 = 0;
            var11 = 0;
            var12 = 0;
            
            if ( isdefined( var7 ) )
            {
                var10 = var7[ "mask" ];
                var11 = var7[ "mask2" ];
                var12 = var7[ "mask3" ];
            }
            
            init_sentry_traps( var0, var1, var9, var8, var10, var11, var5, var2, var4, var12 );
            return;
        }
        
        return;
    }
}

// Params 8
// Size: 0xd9
function killstreakkilled( var0, var1, var2, var3, var4, var5, var6, var7 )
{
    if ( !challengesenabledforplayer( var3 ) )
    {
        return;
    }
    
    var8 = self;
    
    if ( !isplayer( var3 ) )
    {
        return;
    }
    
    if ( !isdefined( var8.owner ) )
    {
        return;
    }
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "player", "isFriendly" ) )
    {
        if ( ![[ scripts\cp_mp\utility\script_utility::getsharedfunc( "player", "isFriendly" ) ]]( var3.team, var8.owner ) )
        {
            if ( isdefined( var6.ref_121d9 ) )
            {
                var6 = var6.ref_121d9;
            }
            
            var9 = ref_14583( var6, var3 );
            var10 = "MOD_UNKNOWN";
            var11 = 0;
            var12 = 0;
            var13 = 0;
            
            if ( isdefined( var3.modifiers ) )
            {
                var11 = var3.modifiers[ "mask" ];
                var12 = var3.modifiers[ "mask2" ];
                var13 = var3.modifiers[ "mask3" ];
            }
            
            init_sentry_traps( undefined, var3, var9, var8, var11, var12, var6, var4, var10, var13 );
            return;
        }
        
        return;
    }
}

// Params 8
// Size: 0x1e
function ondeath( var0, var1, var2, var3, var4, var5, var6, var7 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    self reportchallengeuserevent( "death", 0 );
}

// Params 1
// Size: 0x262
function onplayerkillassist( var0 )
{
    var1 = self;
    
    if ( !challengesenabledforplayer( var1 ) )
    {
        return;
    }
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "player", "isFriendly" ) )
    {
        if ( ![[ scripts\cp_mp\utility\script_utility::getsharedfunc( "player", "isFriendly" ) ]]( var1.team, var0 ) )
        {
            var2 = undefined;
            
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "getGameType" ) )
            {
                var2 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "getGameType" ) ]]();
            }
            
            if ( !isdefined( var2 ) )
            {
                var2 = getdvar( "NKTMKRMSKR" );
            }
            
            var3 = "";
            
            if ( isdefined( var1.primaryweaponobj ) )
            {
                if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "getDefaultWeaponBaseName" ) )
                {
                    var3 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "getDefaultWeaponBaseName" ) ]]( var1.primaryweaponobj.basename );
                }
            }
            
            var4 = "";
            
            if ( isdefined( var1.secondaryweaponobj ) )
            {
                if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "getDefaultWeaponBaseName" ) )
                {
                    var4 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "getDefaultWeaponBaseName" ) ]]( var1.secondaryweaponobj.basename );
                }
            }
            
            var5 = [ var3, var4 ];
            var6 = [ 0, 0 ];
            var7 = 0;
            var8 = level.carnage_enemydummycleanup;
            var9 = relic_amped_is_there_valid_new_victim();
            var10 = "";
            var11 = "";
            var12 = "";
            var13 = "";
            var14 = "";
            var15 = -1;
            var16 = 0;
            var17 = "no_attachments";
            var18 = resetstuckthermite( var1 );
            var1 reportchallengeuserevent( "assist", var6, var5, var7, var8, var18, var9, var17, var10, var12, var11, gettouchinglocaletriggers( var1, var0 ), var13, var14, var15, var16 );
            var12 = play_sound_from_closest_player( var0 );
            
            if ( ( var2 == "br" || var2 == "brtdm" ) && ( isplayer( var0 ) || var12 & 32 ) )
            {
                var19 = var1.primaryweaponobj;
                
                if ( isdefined( var0.attackerdata ) )
                {
                    var20 = var0.attackerdata[ var1.guid ];
                    
                    if ( isdefined( var20 ) )
                    {
                        if ( isdefined( var20.objweapon ) )
                        {
                            var19 = var20.objweapon;
                            
                            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "getDefaultWeaponBaseName" ) )
                            {
                                var3 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "getDefaultWeaponBaseName" ) ]]( var19.basename );
                            }
                        }
                        
                        if ( isdefined( var20.ref_11c8d ) )
                        {
                            var7 = var20.ref_11c8d;
                        }
                        
                        if ( isdefined( var20.ref_11c8e ) )
                        {
                            var8 = var20.ref_11c8e;
                            var8 |= 2097152;
                        }
                    }
                }
                
                init_turrets( var1, var12, var3, var19, var17, var7, var8, undefined, 0 );
                return;
            }
            
            return;
        }
        
        return;
    }
}

// Params 2
// Size: 0x7e
function ref_12047( var0, var1 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    var2 = var0;
    var3 = undefined;
    
    switch ( var1 )
    {
        case "earned":
            var3 = 0;
            break;
        case "carepackage":
            var3 = 1;
            break;
        case "other":
        default:
            var3 = 2;
            break;
    }
    
    var4 = relic_amped_is_there_valid_new_victim();
    var5 = resetstuckthermite();
    var6 = play_stealthy_disguise_vo( self );
    var7 = play_stealthy_disguise_vo( self, 1 );
    self reportchallengeuserevent( "killstreak_available", var2, var3, var4, var5, var6, var7 );
}

// Params 7
// Size: 0x63
function ref_1204a( var0, var1, var2, var3, var4, var5, var6 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    var7 = var0;
    var8 = var1;
    var9 = var2;
    var10 = var3;
    var11 = var4;
    var12 = var5;
    var13 = var6;
    
    if ( var7 == "bradley" )
    {
        var7 = "pac_sentry";
    }
    
    var14 = resetstuckthermite();
    var15 = relic_amped_is_there_valid_new_victim();
    self reportchallengeuserevent( "killstreak_end", var7, var8, var9, var10, var11, var12, var13, var14, var15 );
}

// Params 4
// Size: 0x196
function ref_12032( var0, var1, var2, var3 )
{
    if ( isdefined( var2 ) && isdefined( self ) && !challengesenabledforplayer( var2 ) )
    {
        return;
    }
    
    var4 = var0;
    var5 = var1;
    var6 = 0;
    
    if ( isdefined( var2 ) && scripts\cp_mp\utility\script_utility::issharedfuncdefined( "perk", "hasPerk" ) )
    {
        var7 = scripts\cp_mp\utility\script_utility::getsharedfunc( "perk", "hasPerk" );
        var6 = var2 [[ var7 ]]( "specialty_tactical_recon" );
    }
    
    if ( level.getallactivequestsforteam >= 8 && istrue( var3 ) && isdefined( var2 ) && self.team != var2.team && istrue( var6 ) )
    {
        ref_12c3f( var2, "t9_ch_global_destroy_field_upgrade_with_engineer_or_spotter_perk_for_operator_mission", 1 );
    }
    
    if ( level.getallactivequestsforteam >= 10 && istrue( var3 ) && isdefined( var2 ) && self.team != var2.team )
    {
        ref_12c3f( var2, "t9_ch_global_destroy_field_upgrade_for_operator_mission_s4", 1 );
    }
    
    if ( level.getallactivequestsforteam >= 9 && istrue( var3 ) && isdefined( var2 ) && self.team != var2.team )
    {
        ref_12c3f( var2, "t9_ch_global_field_upgrade_destructions_s3", 1 );
        ref_12c3f( var2, "t9_ch_global_destroy_field_upgrade_for_operator_mission_s3", 1 );
    }
    
    if ( level.getallactivequestsforteam >= 11 && istrue( var3 ) && isdefined( var2 ) && self.team != var2.team && istrue( var6 ) )
    {
        ref_12c3f( var2, "t9_ch_global_destroy_field_upgrade_with_engineer_or_spotter_perk_for_operator_mission_s5", 1 );
    }
    
    if ( level.getallactivequestsforteam >= 11 && istrue( var3 ) && isdefined( var2 ) && self.team != var2.team )
    {
        ref_12c3f( var2, "t9_ch_global_destroy_field_upgrade_for_operator_mission_s5", 1 );
    }
    
    var8 = resetstuckthermite();
    var9 = relic_amped_is_there_valid_new_victim();
    
    if ( challengesenabledforplayer() )
    {
        self reportchallengeuserevent( "field_end", var4, var5, var8, var9 );
        return;
    }
}

// Params 1
// Size: 0x37
function ref_12021( var0 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    if ( level.getallactivequestsforteam >= 12 )
    {
        if ( isdefined( var0 ) && istrue( var0.isequipment ) )
        {
            ref_12c3f( "t9_ch_global_jam_or_wz_emp_field_upgrades_and_scorestreaks_s6", 1 );
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x42
function ref_12003( var0 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    var1 = 0;
    var2 = 0;
    
    if ( isdefined( var0 ) )
    {
        var1 = var0[ "mask" ];
        var2 = var0[ "mask2" ];
    }
    
    var3 = relic_amped_is_there_valid_new_victim();
    var4 = resetstuckthermite();
    self reportchallengeuserevent( "capture", var3, var1, var2, var4 );
}

// Params 1
// Size: 0x42
function ref_1201f( var0 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    var1 = 0;
    var2 = 0;
    
    if ( isdefined( var0 ) )
    {
        var1 = var0[ "mask" ];
        var2 = var0[ "mask2" ];
    }
    
    var3 = relic_amped_is_there_valid_new_victim();
    var4 = resetstuckthermite();
    self reportchallengeuserevent( "defuse", var3, var1, var2, var4 );
}

// Params 1
// Size: 0x42
function ref_12062( var0 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    var1 = 0;
    var2 = 0;
    
    if ( isdefined( var0 ) )
    {
        var1 = var0[ "mask" ];
        var2 = var0[ "mask2" ];
    }
    
    var3 = relic_amped_is_there_valid_new_victim();
    var4 = resetstuckthermite();
    self reportchallengeuserevent( "defuse", var3, var1, var2, var4 );
}

// Params 1
// Size: 0x25
function ref_12096( var0 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    var1 = relic_amped_is_there_valid_new_victim();
    var2 = resetstuckthermite();
    self reportchallengeuserevent( "stun", var0, var1, var2 );
}

// Params 1
// Size: 0x7a
function ref_12092( var0 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    var1 = relic_amped_is_there_valid_new_victim();
    var2 = resetstuckthermite();
    self.watch_for_player_enter_trigger = gettime();
    self.ref_14072 = 1;
    self reportchallengeuserevent( "stim", var0, var1, var2 );
    
    if ( level.getallactivequestsforteam >= 7 )
    {
        ref_12c3f( "t9_ch_global_stim_shot_health_recovery_for_operator_mission", var0 );
    }
    
    if ( level.getallactivequestsforteam >= 9 )
    {
        ref_12c3f( "t9_ch_global_stim_shot_health_recovery_for_operator_mission_s3", var0 );
    }
    
    if ( level.getallactivequestsforteam >= 11 )
    {
        ref_12c3f( "t9_ch_global_stim_shot_health_recovery_for_operator_mission_s5", var0 );
        return;
    }
}

// Params 1
// Size: 0xa3
function ref_1203d( var0 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    var1 = play_stealthy_disguise_vo( self );
    var2 = relic_amped_is_there_valid_new_victim();
    var3 = resetstuckthermite();
    self reportchallengeuserevent( "hack", var0, var1, var2, var3 );
    var4 = 0;
    
    if ( isdefined( self ) && scripts\cp_mp\utility\script_utility::issharedfuncdefined( "perk", "hasPerk" ) )
    {
        var5 = scripts\cp_mp\utility\script_utility::getsharedfunc( "perk", "hasPerk" );
        var4 = self [[ var5 ]]( "specialty_tactical_recon" );
    }
    
    if ( level.getallactivequestsforteam >= 10 )
    {
        if ( istrue( var4 ) )
        {
            ref_12c3f( "t9_ch_global_hack_enemy_field_upgrades_for_operator_mission_s4", 1 );
        }
    }
    
    if ( level.getallactivequestsforteam >= 11 )
    {
        if ( istrue( var4 ) )
        {
            ref_12c3f( "t9_ch_global_hacked_field_upgrade_events_for_operator_missions_s5", 1 );
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0xed
function ondestroyedbytrophy()
{
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    if ( level.getallactivequestsforteam >= 8 )
    {
        ref_12c3f( self.owner, "t9_ch_global_destroy_explosive_with_trophy_for_operator_mission", 1 );
    }
    
    var0 = 0;
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "perk", "hasPerk" ) )
    {
        var1 = scripts\cp_mp\utility\script_utility::getsharedfunc( "perk", "hasPerk" );
        var0 = self.owner [[ var1 ]]( "specialty_tactical_recon" );
    }
    
    if ( level.getallactivequestsforteam >= 9 && var0 && istrue( self.ishacked ) )
    {
        ref_12c3f( self.owner, "t9_ch_global_interceptions_with_hacked_trophy_s3", 1 );
    }
    
    var2 = self getlinkedparent();
    
    if ( level.getallactivequestsforteam >= 9 && isdefined( var2 ) && var2 scripts\cp_mp\vehicles\vehicle::isvehicle() )
    {
        ref_12c3f( self.owner, "t9_ch_global_vehicle_mounted_trophy_intercepts_for_operator_mission_s3", 1 );
    }
    
    if ( level.getallactivequestsforteam >= 11 )
    {
        ref_12c3f( self.owner, "t9_ch_global_destroy_projectiles_with_trophy_for_operator_mission_s5", 1 );
        ref_12c3f( self.owner, "t9_ch_global_hacked_field_upgrade_events_s5", 1 );
        return;
    }
}

// Params 2
// Size: 0x7f
function gettouchinglocaletriggers( var0, var1 )
{
    var2 = "";
    
    if ( !isdefined( level.localetriggers ) )
    {
        return var2;
    }
    
    var3 = 0;
    
    foreach ( var5 in level.localetriggers )
    {
        if ( var0 istouching( var5 ) || isdefined( var1 ) && var1 istouching( var5 ) )
        {
            if ( isdefined( var5.localeid ) )
            {
                if ( var3 )
                {
                    var2 += "|";
                }
                
                var2 += var5.localeid;
                var3 = 1;
            }
        }
    }
    
    return var2;
}

// Params 1
// Size: 0xa8
function run_laser_vfx_loop( var0 )
{
    if ( !isdefined( level.localetriggers ) )
    {
        return -1;
    }
    
    foreach ( var2 in level.localetriggers )
    {
        if ( var0 istouching( var2 ) )
        {
            var3 = isdefined( var2.localeid ) && var2.localeid > 0;
            var4 = isdefined( var0.wasingulag ) && var0.wasingulag == var2.localeid;
            
            if ( var3 && !var4 )
            {
                if ( !isdefined( var0.wasingulag ) )
                {
                    var0.wasingulag = 0;
                }
                
                var0.wasingulag = var2.localeid;
                return var2.localeid;
            }
        }
    }
    
    return -1;
}

// Params 2
// Size: 0x32
function ref_1200a( var0, var1 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    var2 = relic_amped_is_there_valid_new_victim();
    self reportchallengeuserevent( "contract_start", gettouchinglocaletriggers( self, undefined ), gettouchinglocaletriggers( var1, undefined ), resetstuckthermite(), var2, var0 );
}

// Params 3
// Size: 0xd9
function ref_12009( var0, var1, var2 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    if ( var1 == level.questinfo.hotfootabsloops )
    {
        if ( !isdefined( self.hotfootreset ) )
        {
            self.hotfootreset = 1;
        }
        else
        {
            self.hotfootreset++;
        }
        
        if ( self.hotfootreset == 3 )
        {
            ref_12c3f( "t9_ch_global_complete_three_contracts_one_match_s1_wz", 1 );
        }
        
        if ( var0 == "domination" )
        {
            if ( level.getallactivequestsforteam >= 10 )
            {
                ref_12c3f( "t9_ch_global_objective_capture_for_operator_mission_s4", 1 );
            }
            
            if ( level.getallactivequestsforteam >= 11 )
            {
                ref_12c3f( "t9_ch_global_objective_capture_for_operator_mission_s5", 1 );
            }
        }
        
        if ( level.getallactivequestsforteam >= 11 )
        {
            ref_12c3f( "t9_ch_global_clear_2_attackers_or_wz_contract_s5", 1 );
        }
        
        if ( level.getallactivequestsforteam >= 12 )
        {
            ref_12c3f( "t9_ch_global_finish_match_with_five_objective_kills_or_wz_bounty_s6", 1 );
        }
    }
    
    var3 = relic_amped_is_there_valid_new_victim();
    self reportchallengeuserevent( "contract_end", var0, var1, isalive( self ), var2, resetstuckthermite(), var3 );
}

// Params 2
// Size: 0x7e
function ref_1204b( var0, var1 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    if ( var1 == "supply_drop" )
    {
        ref_12c3f( "t9_ch_global_complete_loadout_drop_for_operator_mission", 1 );
    }
    else if ( var1 == "teamrevive" )
    {
        ref_12c3f( "t9_ch_global_teammate_buyback_for_operator_mission", 1 );
    }
    else if ( level.getallactivequestsforteam >= 8 && var1 == "killstreak" )
    {
        ref_12c3f( "t9_ch_global_killstreaks_purchased_or_acquired_s2", 1 );
    }
    
    var2 = relic_amped_is_there_valid_new_victim();
    self reportchallengeuserevent( "buy_item", var0, var1, resetstuckthermite(), var2 );
}

// Params 2
// Size: 0x1a2
function ref_1205f( var0, var1 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    var2 = level.getallactivequestsforteam;
    var3 = 0;
    var4 = 0;
    var5 = 0;
    var6 = 0;
    var7 = 0;
    var8 = 0;
    
    if ( var0 == "weapon" )
    {
        var3 = 1;
        
        if ( isdefined( var1 ) )
        {
            var6 = var1;
        }
    }
    else if ( var0 == "plunder" )
    {
        var4 = 1;
        
        if ( isdefined( var1 ) )
        {
            var8 = var1;
        }
    }
    else if ( var2 >= 8 && var0 == "killstreak" )
    {
        ref_12c3f( "t9_ch_global_killstreaks_purchased_or_acquired_s2", 1 );
    }
    else if ( var2 >= 8 && var0 == "scavengerAmmo" )
    {
        ref_12c3f( "t9_ch_global_ammo_pickup_scavenger_s2", 1 );
        ref_12c3f( "t9_ch_global_ammo_pickup_scavenger_for_operator_mission", 1 );
    }
    else if ( var0 == "equipment" )
    {
        var5 = 1;
        
        if ( isdefined( var1 ) )
        {
            var7 = var1;
        }
    }
    
    if ( var2 >= 9 && var0 == "scavengerAmmo" )
    {
        ref_12c3f( "t9_ch_global_ammo_pickup_scavenger_for_operator_mission_s3", 1 );
    }
    
    if ( var2 >= 10 && var0 == "scavengerAmmo" )
    {
        ref_12c3f( "t9_ch_global_ammo_pickup_scavenger_for_operator_mission_s4", 1 );
    }
    
    if ( var2 >= 11 && var0 == "scavengerAmmo" )
    {
        ref_12c3f( "t9_ch_global_ammo_pickup_scavenger_for_operator_mission_s5", 1 );
    }
    
    if ( var2 >= 12 && var0 == "scavengerAmmo" )
    {
        ref_12c3f( "t9_ch_global_ammo_pickup_scavenger_for_operator_mission_s6", 1 );
    }
    
    if ( var2 >= 12 && var0 == "killstreak" )
    {
        ref_12c3f( "t9_ch_global_killstreaks_purchased_or_acquired_for_operator_mission_s6", 1 );
    }
    
    var9 = relic_amped_is_there_valid_new_victim();
    var10 = gettouchinglocaletriggers( self, undefined );
    var11 = getchallengemapid();
    self reportchallengeuserevent( "pickup", var3, var4, 0, resetstuckthermite(), var10, var9, var5, var6, var7, var8, var11 );
}

// Params 1
// Size: 0x14a
function ref_12060( var0 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    if ( getdvar( "scr_br_gametype", "" ) == "dmz" || getdvar( "scr_br_gametype", "" ) == "rat_race" || getdvar( "scr_br_gametype", "" ) == "gold_war" )
    {
        return;
    }
    
    var1 = var0 * 100;
    
    if ( level.getallactivequestsforteam >= 9 )
    {
        ref_12c3f( "t9_ch_global_earn_score_for_operator_mission_s3", var1 );
    }
    
    if ( level.getallactivequestsforteam >= 11 )
    {
        ref_12c3f( "t9_ch_global_earn_score_or_wz_cash_for_operator_mission_s5", var1 );
        ref_12c3f( "t9_ch_global_earn_score_or_wz_cash_s5", var1 );
        ref_12c3f( "t9_ch_common_opbundle_01_objective_3", var1 );
    }
    
    if ( level.getallactivequestsforteam >= 12 )
    {
        ref_12c3f( "t9_ch_global_earn_score_or_wz_cash_for_operator_mission_s6", var1 );
        ref_12c3f( "t9_ch_common_opbundle_05_objective_3", var1 );
        
        if ( !isdefined( self.get_tv_station_infil_rider_start_targetname ) )
        {
            self.get_tv_station_infil_rider_start_targetname = 0;
        }
        
        self.get_tv_station_infil_rider_start_targetname += var1;
        
        while ( self.get_tv_station_infil_rider_start_targetname >= 15000 )
        {
            ref_12c3f( "t9_ch_common_opbundle_04_objective_4", 1 );
            self.get_tv_station_infil_rider_start_targetname -= 15000;
        }
        
        if ( !isdefined( self.get_trap_room_spawnpoints ) )
        {
            if ( !isdefined( self.get_turret_target_pos ) )
            {
                self.get_turret_target_pos = 0;
            }
            
            self.get_turret_target_pos += var1;
            
            if ( self.get_turret_target_pos >= 25000 )
            {
                ref_12c3f( "t9_ch_common_opbundle_06_objective_4", 1 );
                self.get_trap_room_spawnpoints = 1;
                return;
            }
            
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x38
function ref_12002()
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    var0 = relic_amped_is_there_valid_new_victim();
    var1 = gettouchinglocaletriggers( self, undefined );
    var2 = getchallengemapid();
    self reportchallengeuserevent( "pickup", 0, 0, 1, resetstuckthermite(), var1, var0, 0, 0, 0, var2 );
}

// Params 1
// Size: 0x22
function ref_120a8( var0 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    var1 = relic_amped_is_there_valid_new_victim();
    self reportchallengeuserevent( "use_item", var0, resetstuckthermite(), var1 );
}

// Params 1
// Size: 0x3d
function ref_12098( var0 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    if ( level.getallactivequestsforteam >= 7 )
    {
        ref_12c3f( "t9_ch_global_resupply_teammates_for_operator_mission", 1 );
    }
    
    if ( level.getallactivequestsforteam >= 10 )
    {
        ref_12c3f( "t9_ch_global_support_assist_score_event_s4", 1 );
        return;
    }
}

// Params 2
// Size: 0x2b
function ref_12004( var0, var1 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    if ( !isdefined( var1 ) )
    {
        var1 = 0;
    }
    
    var2 = relic_amped_is_there_valid_new_victim();
    self reportchallengeuserevent( "collect_item", var0, resetstuckthermite(), var2, var1 );
}

// Params 2
// Size: 0x2b
function ref_120a4( var0, var1 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    if ( !isdefined( var1 ) )
    {
        var1 = 0;
    }
    
    var2 = relic_amped_is_there_valid_new_victim();
    self reportchallengeuserevent( "collect_item", var0, resetstuckthermite(), var2, var1 );
}

// Params 1
// Size: 0x22
function ref_12061( var0 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    var1 = relic_amped_is_there_valid_new_victim();
    self reportchallengeuserevent( "ping", var0, resetstuckthermite(), var1 );
}

// Params 1
// Size: 0x22
function ref_12053( var0 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    var1 = relic_amped_is_there_valid_new_victim();
    self reportchallengeuserevent( "loadout", var0, resetstuckthermite(), var1 );
}

// Params 2
// Size: 0x6d
function ref_12050( var0, var1 )
{
    var2 = relic_amped_is_there_valid_new_victim();
    
    if ( var0 == var1 )
    {
        if ( challengesenabledforplayer( var0 ) )
        {
            var0 reportchallengeuserevent( "revive", 1, 1, resetstuckthermite( var0 ), var2 );
            return;
        }
        
        return;
    }
    
    if ( challengesenabledforplayer( var0 ) )
    {
        var0 reportchallengeuserevent( "revive", 1, 0, resetstuckthermite( var0 ), var2 );
    }
    
    if ( challengesenabledforplayer( var1 ) )
    {
        var1 reportchallengeuserevent( "revive", 0, 1, resetstuckthermite( var0 ), var2 );
        return;
    }
}

// Params 1
// Size: 0x46
function ref_1203c( var0 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    var1 = relic_amped_is_there_valid_new_victim();
    self reportchallengeuserevent( "gulag_end_match", var0, resetstuckthermite(), var1 );
    
    if ( level.getallactivequestsforteam >= 11 )
    {
        var2 = 1;
        
        if ( var0 == var2 )
        {
            ref_12c3f( "t9_ch_global_gunfight_or_wz_gulag_wins_s5", 1 );
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x361
function ref_1205a( var0 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    if ( var0 <= 0 )
    {
        return;
    }
    
    if ( var0 <= 15 )
    {
        ref_12c3f( "t9_ch_global_earn_team_top_15_for_operator_mission", 1 );
    }
    
    if ( var0 <= 3 )
    {
        ref_12c3f( "t9_ch_global_place_top3_ft_s1", 1 );
    }
    
    var1 = undefined;
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "getEnemyTeams" ) )
    {
        var1 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "getEnemyTeams" ) ]]( self.team );
    }
    
    var2 = 0;
    
    if ( var1.size != 0 )
    {
        var2 = var0 / var1.size;
    }
    
    if ( var2 <= 0.25 )
    {
        ref_12c3f( "t9_ch_global_top_25_percent_finish_s3", 1 );
    }
    
    if ( level.getallactivequestsforteam >= 10 )
    {
        if ( isdefined( self.kills ) && isdefined( self.assists ) && isdefined( self.deaths ) )
        {
            var3 = self.kills + self.assists;
            var4 = 0;
            
            if ( var3 > 0 )
            {
                if ( self.deaths > 0 )
                {
                    var4 = var3 / self.deaths;
                }
                else
                {
                    var4 = var3 / 1;
                }
            }
            
            if ( var4 >= 2 )
            {
                ref_12c3f( "t9_ch_global_finish_match_with_2x_more_ekia_than_deaths_s4", 1 );
            }
            
            if ( var3 > self.deaths )
            {
                ref_12c3f( "t9_ch_global_finish_match_with_more_ekia_than_deaths_for_operator_mission_s4", 1 );
                
                if ( level.getallactivequestsforteam >= 11 )
                {
                    ref_12c3f( "t9_ch_global_finish_match_with_more_ekia_than_deaths_for_operator_mission_s5", 1 );
                }
                
                if ( level.getallactivequestsforteam >= 12 )
                {
                    ref_12c3f( "t9_ch_global_finish_match_with_more_ekia_than_deaths_for_operator_mission_s6", 1 );
                    ref_12c3f( "t9_ch_common_opbundle_05_objective_4", 1 );
                }
            }
        }
        
        if ( var2 <= 0.1 )
        {
            ref_12c3f( "t9_ch_global_top_10_percent_finish_s4", 1 );
        }
        
        if ( var2 <= 0.25 )
        {
            ref_12c3f( "t9_ch_global_finish_match_in_top_25_percent_for_operator_mission_s4", 1 );
            
            if ( level.getallactivequestsforteam >= 12 )
            {
                ref_12c3f( "t9_ch_global_finish_match_in_top_25_percent_for_operator_mission_s6", 1 );
                ref_12c3f( "t9_ch_common_opbundle_04_objective_2", 1 );
                ref_12c3f( "t9_ch_common_opbundle_07_objective_4", 1 );
            }
        }
    }
    
    if ( level.getallactivequestsforteam >= 11 )
    {
        if ( var2 <= 0.5 )
        {
            ref_12c3f( "t9_ch_common_opbundle_01_objective_4", 1 );
        }
        
        if ( isdefined( self.kills ) && isdefined( self.assists ) && isdefined( self.deaths ) )
        {
            var3 = self.kills + self.assists;
            
            if ( var3 > self.deaths )
            {
                ref_12c3f( "t9_ch_common_opbundle_02_objective_4", 1 );
            }
        }
    }
    
    if ( level.getallactivequestsforteam >= 12 )
    {
        if ( isdefined( level.disable_super_in_turret.name ) && level.disable_super_in_turret.name == "gxp" )
        {
            ref_12c3f( "t9_ch_common_season_6_wz_event_challenge_1", 1 );
            
            if ( var0 <= 10 )
            {
                ref_12c3f( "t9_ch_common_season_6_wz_event_challenge_2", 1 );
            }
        }
    }
    
    var5 = getdvar( "scr_br_gametype" );
    
    if ( var0 == 1 && var5 == "dbd" && scripts\cp_mp\utility\game_utility::turretdisabled() )
    {
        ref_120a4( "dbd_atlantis_victory_reward" );
    }
    
    if ( var5 == "vov" )
    {
        if ( var0 == 1 )
        {
            ref_120a4( "vov_victory_reward" );
        }
        
        ref_120a4( "vov_participation_reward" );
    }
    
    if ( scripts\cp_mp\utility\game_utility::tutorialzoneenter() && var0 == 1 )
    {
        ref_120a4( "vr_victory_reward" );
    }
    
    if ( var0 == 1 && ( var5 == "rebirth" || var5 == "rebirth_reverse" || var5 == "rebirth_dbd" || var5 == "rebirth_dbd_reverse" ) )
    {
        ref_12004( "resu_victory" );
    }
    
    if ( var0 == 1 && var5 == "zxp" && !ref_125f3() )
    {
        ref_12004( "zxp_win" );
    }
    
    if ( var0 == 1 && ( var5 == "rebirth_dbd" || var5 == "rebirth_dbd_reverse" ) && self.kills >= 15 )
    {
        ref_12004( "dbd_w_15" );
        return;
    }
}

// Params 0
// Size: 0x40
function ref_1208f()
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    reportchallengestatamount( "spray", 1 );
    var0 = run_laser_vfx_loop( self );
    
    if ( var0 != -1 )
    {
        var1 = resetstuckthermite();
        var2 = relic_amped_is_there_valid_new_victim();
        self reportchallengeuserevent( "spray", var0, var1, var2 );
        return;
    }
}

// Params 0
// Size: 0x17
function ongesture()
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    reportchallengestatamount( "gesture", 1 );
}

// Params 2
// Size: 0xf2
function ref_1301e( var0, var1 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    var2 = relic_amped_is_there_valid_new_victim();
    var3 = gettouchinglocaletriggers( self, undefined );
    var4 = resetstuckthermite();
    var5 = "mv_event_intel_1";
    
    switch ( var0 )
    {
        case "mv_event_intel_1":
            self reportchallengeuserevent( "aggregate", var5, var2, var4, var3, var1, 0, 0, 0, 0 );
            break;
        case "mv_event_intel_3":
            self reportchallengeuserevent( "aggregate", var5, var2, var4, var3, 0, var1, 0, 0, 0 );
            break;
        case "mv_event_intel_4":
            self reportchallengeuserevent( "aggregate", var5, var2, var4, var3, 0, 0, var1, 0, 0 );
            break;
        case "mv_event_intel_5":
            self reportchallengeuserevent( "aggregate", var5, var2, var4, var3, 0, 0, 0, var1, 0 );
            break;
        case "mv_event_intel_6":
            self reportchallengeuserevent( "aggregate", var5, var2, var4, var3, 0, 0, 0, 0, var1 );
            break;
        default:
            self reportchallengeuserevent( "aggregate", var0, var2, var4, var3, var1, 0, 0, 0, 0 );
            break;
    }
}

// Params 1
// Size: 0x18
function ref_12000( var0 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    ref_12c3f( "t9_ch_global_block_damage_inserted_armor_for_operator_mission_s3", var0 );
}

// Params 2
// Size: 0x7f
function ref_12007( var0, var1 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    switch ( weaponclass( var0 ) )
    {
        case "sniper":
            if ( level.getallactivequestsforteam >= 10 && var1 > 0 && var1 % 3 == 0 )
            {
                ref_12c3f( "t9_ch_global_fire_x_consecutive_damaging_shots_with_sniper_rifle_s4", 1 );
            }
            
            if ( level.getallactivequestsforteam >= 12 && var1 > 0 && var1 % 3 == 0 )
            {
                ref_12c3f( "t9_ch_global_fire_x_consecutive_damaging_shots_with_sniper_rifle_for_operator_mission_s6", 1 );
            }
            
            break;
        default:
            break;
    }
}

// Params 0
// Size: 0x82
function ref_12094()
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    if ( level.getallactivequestsforteam >= 9 )
    {
        ref_12c3f( "t9_ch_global_kills_scorestreak_or_loadout_drop_weapons_s3", 1 );
    }
    
    if ( level.getallactivequestsforteam >= 10 )
    {
        ref_12c3f( "t9_ch_global_scorestreak_weapon_or_stopping_power_kill_for_operator_mission_s4", 1 );
    }
    
    if ( level.getallactivequestsforteam >= 12 )
    {
        ref_12c3f( "t9_ch_global_scorestreak_weapon_or_stopping_power_kill_for_operator_mission_s6", 1 );
        
        if ( !isdefined( self.ref_12a8a ) )
        {
            self.ref_12a8a = 0;
        }
        
        self.ref_12a8a++;
        
        if ( self.ref_12a8a >= 2 )
        {
            ref_12c3f( "t9_ch_global_rapid_kills_with_scorestreak_weapon_or_wz_stopping_power_s6", 1 );
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x3b
function ref_1207c()
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    if ( level.getallactivequestsforteam >= 9 )
    {
        ref_12c3f( "t9_ch_global_detected_kill_field_mic_or_recon_drone_for_operator_mission_s3", 1 );
    }
    
    if ( level.getallactivequestsforteam >= 11 )
    {
        ref_12c3f( "t9_ch_global_detected_kill_field_mic_or_recon_drone_for_operator_mission_s5", 1 );
        return;
    }
}

// Params 2
// Size: 0x1cb
function ref_14583( var0, var1 )
{
    var2 = undefined;
    
    switch ( var0.basename )
    {
        case "lighttank_tur_ks_mp":
        case "tur_gun_lighttank_ks_mp":
        case "bradley_tow_proj_mp":
        case "lighttank_tur_mp":
        case "pac_sentry_turret_mp":
        case "tur_gun_payload_truck_mp":
        case "bradley_tow_proj_ks_mp":
        case "tur_gun_little_bird_left_mp":
        case "tur_gun_little_bird_right_mp":
        case "tur_gun_cargo_truck_mp":
        case "tur_gun_lighttank_mp":
            var2 = "iav_weapon_mp";
            break;
        case "little_bird_mp":
            var2 = "little_bird_mp";
            break;
        case "tur_apc_rus_mp":
            var2 = "tur_apc_rus_mp";
            break;
        default:
            var2 = undefined;
            break;
    }
    
    if ( !isdefined( var2 ) )
    {
        var2 = "";
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "equipment", "getEquipmentRefFromWeapon" ) )
        {
            var2 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "equipment", "getEquipmentRefFromWeapon" ) ]]( var0 );
        }
        
        if ( !isdefined( var2 ) )
        {
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "getDefaultWeaponBaseName" ) )
            {
                var2 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "getDefaultWeaponBaseName" ) ]]( var0.basename );
            }
        }
        
        if ( var2 == "equip_throwing_knife_fire" || var2 == "equip_throwing_knife_electric" || var2 == "equip_throwing_knife_drill" )
        {
            var2 = "equip_throwing_knife";
        }
    }
    
    var3 = "";
    
    if ( isdefined( var1.secondaryweaponobj ) && isdefined( var1.primaryweaponobj ) )
    {
        if ( var0 == var1.primaryweaponobj )
        {
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "getDefaultWeaponBaseName" ) )
            {
                var3 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "getDefaultWeaponBaseName" ) ]]( var1.secondaryweaponobj.basename );
            }
        }
        else if ( var0 == var1.secondaryweaponobj )
        {
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "getDefaultWeaponBaseName" ) )
            {
                var3 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "getDefaultWeaponBaseName" ) ]]( var1.primaryweaponobj.basename );
            }
        }
    }
    
    var4 = [ var2, var3 ];
    return var4;
}

// Params 2
// Size: 0x58
function ref_12c3f( var0, var1 )
{
    if ( !isplayer( self ) || isai( self ) )
    {
        return;
    }
    
    if ( level.play_intel_collect_vo )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "challenges", "canSendT9UserEvent" ) )
        {
            var2 = self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "challenges", "canSendT9UserEvent" ) ]]( var0 );
            
            if ( !var2 )
            {
                return;
            }
        }
    }
    
    self reportchallengeuserevent( "t9_challenge", var0, var1 );
}

// Params 0
// Size: 0x3ae
function ref_13276()
{
    if ( isdefined( level.ref_139e2 ) )
    {
        return;
    }
    
    var0 = [];
    GscBinSkip0( 0x2e, "iw8_pi_t9burst_mp", "t9_ch_pistol_burst_t9_" );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 1
// Size: 0x4f
function routers_picked_up( var0 )
{
    ref_13276();
    var1 = level.ref_139e2[ var0 ];
    
    if ( isdefined( var1 ) )
    {
        var2 = var0;
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "getWeaponRootName" ) )
        {
            var2 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "getWeaponRootName" ) ]]( var0 );
        }
        
        if ( !scripts\cp_mp\utility\weapon_utility::vehicle_clearpreventplayercollisiondamagefortimeafterexit( var2 ) )
        {
            var1 = undefined;
        }
    }
    
    return var1;
}

// Params 8
// Size: 0x3be9
function init_turrets( var0, var1, var2, var3, var4, var5, var6, var7 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    var8 = level.getallactivequestsforteam;
    var9 = 1;
    var10 = 0;
    
    if ( var7 )
    {
        if ( isdefined( self.killcountthislife ) )
        {
            var9 = self.killcountthislife + 1;
        }
        
        if ( self.recentkillcount > 1 && !istrue( self.ref_11e04 ) )
        {
            self.ref_11e04 = 1;
            var10 = 1;
        }
    }
    
    var11 = "";
    var12 = 0;
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "equipment", "getEquipmentTableInfo" ) )
    {
        var13 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "equipment", "getEquipmentTableInfo" ) ]]( var1 );
        
        if ( isdefined( var13 ) )
        {
            var12 = var13.defaultslot == "primary";
        }
        else if ( var1 != "iav_weapon_mp" )
        {
            var11 = weaponclass( var1 );
        }
    }
    else if ( var1 != "iav_weapon_mp" )
    {
        var11 = weaponclass( var1 );
    }
    
    var14 = 0;
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "killstreak", "isKillstreakWeapon" ) )
    {
        var14 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "killstreak", "isKillstreakWeapon" ) ]]( var2.basename );
    }
    
    var15 = "";
    
    if ( istrue( var14 ) )
    {
        var15 = getkillstreaknamefromweapon( var2 );
    }
    
    var16 = 0;
    var17 = 0;
    var18 = 0;
    var19 = 0;
    var20 = 0;
    var21 = 0;
    
    if ( isdefined( var6 ) && isdefined( var6.equipmentref ) )
    {
        if ( var6.equipmentref == "equip_c4" )
        {
            var16 = 1;
        }
        
        if ( var6.equipmentref == "equip_molotov" )
        {
            var17 = 1;
        }
        
        if ( var6.equipmentref == "equip_at_mine" )
        {
            var18 = 1;
        }
        
        if ( var6.equipmentref == "equip_semtex" )
        {
            var19 = 1;
        }
        
        if ( var6.equipmentref == "equip_frag" )
        {
            var20 = 1;
        }
        
        if ( var6.equipmentref == "equip_throwing_knife" )
        {
            var21 = 1;
        }
    }
    
    var22 = scripts\cp_mp\utility\player_utility::isinvehicle();
    var23 = undefined;
    var24 = 0;
    
    if ( istrue( var22 ) )
    {
        var23 = scripts\cp_mp\utility\player_utility::getvehicle();
        
        if ( var23 scripts\cp_mp\vehicles\vehicle::vehiclecanfly() )
        {
            var24 |= 4;
        }
        else
        {
            var24 |= 2;
        }
    }
    
    var25 = 0;
    var26 = 0;
    var27 = 0;
    var28 = 0;
    var29 = 0;
    var30 = 0;
    var31 = 0;
    var32 = 0;
    var33 = 0;
    var34 = 0;
    var35 = 0;
    var36 = 0;
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "perk", "hasPerk" ) )
    {
        var37 = scripts\cp_mp\utility\script_utility::getsharedfunc( "perk", "hasPerk" );
        var25 = [[ var37 ]]( "specialty_restock" );
        var26 = [[ var37 ]]( "specialty_recharge_equipment" );
        var27 = [[ var37 ]]( "specialty_tac_resist" );
        var28 = [[ var37 ]]( "specialty_stun_resistance" );
        var29 = [[ var37 ]]( "specialty_coldblooded" );
        var30 = [[ var37 ]]( "specialty_surveillance" );
        var31 = [[ var37 ]]( "specialty_tracker" );
        var32 = [[ var37 ]]( "specialty_ghost" );
        var33 = [[ var37 ]]( "specialty_tactical_recon" );
        var34 = [[ var37 ]]( "specialty_eod" );
        var35 = [[ var37 ]]( "specialty_hustle" );
        var36 = [[ var37 ]]( "specialty_gung_ho" );
    }
    
    var38 = routers_picked_up( var1 );
    var39 = isdefined( var38 ) && turn_on_have_target_hud( var1 );
    
    if ( !( var0 & 1 ) )
    {
        if ( var7 )
        {
            if ( var39 )
            {
                if ( var0 & 8 )
                {
                    ref_12c3f( var38 + "destroy_vehicle_ground", 1 );
                }
                
                if ( var0 & 4 )
                {
                    ref_12c3f( var38 + "destroy_vehicle_air", 1 );
                }
                
                if ( var0 & 98 && var1 != "iw8_sn_t9crossbow_mp" )
                {
                    ref_12c3f( var38 + "destroy_any", 1 );
                }
                
                if ( var0 & 32 && var11 == "rocketlauncher" && var1 != "iw8_sn_t9crossbow_mp" )
                {
                    if ( !isdefined( self.ref_12d7b ) )
                    {
                        self.ref_12d7b = 0;
                    }
                    
                    self.ref_12d7b += 1;
                    
                    if ( self.ref_12d7b == 3 )
                    {
                        ref_12c3f( var38 + "destroy_3_vehicles_in_one_game", 1 );
                    }
                }
                
                if ( ( var0 & 4 || var0 & 2 ) && var11 == "rocketlauncher" )
                {
                    if ( var8 >= 8 )
                    {
                        ref_12c3f( "t9_ch_global_destroy_aircraft_with_launchers_for_operator_mission", 1 );
                    }
                    
                    if ( var8 >= 11 )
                    {
                        ref_12c3f( "t9_ch_global_destroy_aircraft_with_launchers_for_operator_mission_s5", 1 );
                    }
                }
            }
            
            if ( var0 & 32 )
            {
                ref_12c3f( "t9_ch_global_destroy_vehicle_for_operator_unlock", 1 );
                ref_12c3f( "t9_ch_global_destroy_vehicle_for_operator_mission", 1 );
                ref_12c3f( "t9_ch_global_destroy_vehicle_for_operator_mission_op2", 1 );
            }
            
            if ( var8 >= 7 )
            {
                if ( var0 & 8 && istrue( var16 ) )
                {
                    ref_12c3f( "t9_ch_global_satchel_charge_ground_vehicle_destructions_s1", 1 );
                }
                
                if ( var0 & 6 )
                {
                    ref_12c3f( "t9_ch_global_destroy_aircraft_s1", 1 );
                }
            }
            
            if ( var8 >= 8 )
            {
                if ( var0 & 8 )
                {
                    ref_12c3f( "t9_ch_global_ground_vehicle_destructions_s2", 1 );
                    ref_12c3f( "t9_ch_global_ground_vehicle_destructions_for_operator_mission", 1 );
                    
                    if ( istrue( var18 ) )
                    {
                        ref_12c3f( "t9_ch_global_land_mine_ground_vehicle_destructions_s2", 1 );
                    }
                }
            }
            
            if ( var8 >= 9 )
            {
                var40 = isdefined( var5 ) && ( var5 & 65536 || var5 & 4096 );
                var41 = var15 == "cruise_predator" || var15 == "pac_sentry" || var15 == "bradley" || var15 == "chopper_gunner" || var15 == "juggernaut";
                
                if ( ( var40 || var41 ) && var0 & 32 )
                {
                    ref_12c3f( "t9_ch_global_vehicle_destruction_in_vehicle_s3", 1 );
                }
                
                if ( var0 & 32 )
                {
                    ref_12c3f( "t9_ch_global_destroy_vehicle_for_operator_mission_s3", 1 );
                }
            }
            
            if ( var8 >= 10 )
            {
                if ( var0 & 34 )
                {
                    ref_12c3f( "t9_ch_global_destroy_vehicle_or_scorestreak_for_operator_mission_s4", 1 );
                    ref_12c3f( "t9_ch_global_destroy_vehicle_or_scorestreak_s4", 1 );
                }
            }
            
            if ( var8 >= 11 )
            {
                if ( var0 & 34 )
                {
                    ref_12c3f( "t9_ch_global_destroy_vehicle_or_scorestreak_for_operator_mission_s5", 1 );
                }
            }
        }
        
        return;
    }
    
    if ( var4 & 8 && isdefined( var2 ) && isdefined( var2.attachments ) && var7 )
    {
        var42 = undefined;
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "attachmentMap_toBase" ) )
        {
            var42 = scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "attachmentMap_toBase" );
        }
        
        foreach ( var44 in var2.attachments )
        {
            var45 = "";
            
            if ( isdefined( var42 ) )
            {
                var45 = [[ var42 ]]( var44 );
            }
            
            var46 = tablelookup( "mp/attachmenttable.csv", 5, var45, 2 );
            
            if ( isdefined( var46 ) && var46 == "optic" )
            {
                var47 = tablelookup( "mp/attachmenttable.csv", 4, var44, 11 );
                
                if ( isdefined( level.ref_139e1[ var47 ] ) )
                {
                    ref_12c3f( level.ref_139e1[ var47 ], 1 );
                }
                
                break;
            }
        }
    }
    
    if ( var39 )
    {
        ref_12c3f( var38 + "ekia", 1 );
        
        if ( var7 )
        {
            ref_12c3f( var38 + "kills", 1 );
            
            if ( var9 % 2 == 0 )
            {
                ref_12c3f( var38 + "killstreak_3", 1 );
            }
            
            if ( var9 % 5 == 0 )
            {
                ref_12c3f( var38 + "killstreak_5", 1 );
            }
            
            if ( isdefined( self.ref_12a86 ) && isdefined( self.ref_12a86[ var2.basename ] ) && self.ref_12a86[ var2.basename ] == 2 )
            {
                ref_12c3f( var38 + "multikill_2", 1 );
            }
            
            if ( var4 & 268435456 )
            {
                ref_12c3f( var38 + "kill_enemy_while_holding_breath", 1 );
            }
            
            if ( var4 & 4096 )
            {
                ref_12c3f( var38 + "kill_enemy_when_injured", 1 );
            }
            
            if ( var4 & 256 )
            {
                ref_12c3f( var38 + "kill_enemy_while_sliding", 1 );
            }
            
            if ( var5 & 1048576 )
            {
                if ( var1 == "iw8_sn_t9crossbow_mp" && !( var5 & 1073741824 ) )
                {
                    ref_12c3f( var38 + "kill_enemy_taking_cover_from_you", 1 );
                }
                else
                {
                    ref_12c3f( var38 + "kill_smoked_blinded_stunned", 1 );
                }
            }
            
            if ( var5 & 524288 )
            {
                if ( var1 == "iw8_sn_t9crossbow_mp" && !( var5 & 1073741824 ) )
                {
                    ref_12c3f( var38 + "kill_enemy_taking_cover_from_you", 1 );
                }
                else
                {
                    ref_12c3f( var38 + "kill_detected_stunned_blinded", 1 );
                }
            }
            
            if ( var4 & 262144 )
            {
                if ( var1 != "iw8_sn_t9crossbow_mp" )
                {
                    ref_12c3f( var38 + "kill_enemy_taking_cover_from_you", 1 );
                }
            }
            
            if ( var4 & 4 )
            {
                ref_12c3f( var38 + "backstabber_kill", 1 );
            }
            
            if ( var4 & 262144 )
            {
                ref_12c3f( var38 + "longshot_kill", 1 );
            }
            
            if ( var4 & 1048576 )
            {
                if ( var1 == "iw8_sn_t9crossbow_mp" )
                {
                    ref_12c3f( var38 + "destroy_any", 1 );
                }
                else
                {
                    ref_12c3f( var38 + "headshots", 1 );
                }
            }
            
            if ( var4 & 1 )
            {
                if ( var1 == "iw8_sn_t9crossbow_mp" )
                {
                    ref_12c3f( var38 + "destroy_3_vehicles_in_one_game", 1 );
                }
                else
                {
                    ref_12c3f( var38 + "kill_enemy_one_bullet_sniper", 1 );
                }
            }
            
            if ( var4 & 524288 )
            {
                ref_12c3f( var38 + "point_blank_kill", 1 );
            }
        }
    }
    
    if ( var7 && var5 & 256 && isdefined( self.weaponlist ) )
    {
        foreach ( var50 in self.weaponlist )
        {
            var51 = "";
            
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "getDefaultWeaponBaseName" ) )
            {
                var51 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "getDefaultWeaponBaseName" ) ]]( var50.basename );
            }
            
            var52 = routers_picked_up( var51 );
            
            if ( isdefined( var52 ) && turn_on_have_target_hud( var51 ) )
            {
                ref_12c3f( var52 + "finishing_move_kill", 1 );
            }
        }
    }
    
    if ( var7 )
    {
        if ( var11 == "rocketlauncher" )
        {
            ref_12c3f( "t9_ch_global_kill_with_launcher_for_operator_mission", 1 );
        }
        
        if ( var11 == "spread" )
        {
            if ( !isdefined( self.intel_guys ) )
            {
                self.intel_guys = 1;
            }
            else
            {
                self.intel_guys++;
            }
            
            if ( turn_on_have_target_hud( "iw8_sh_t9fullauto_mp" ) && self.intel_guys == 3 && !istrue( self.shouldzombiespawntags ) )
            {
                ref_12c3f( "t9_ch_global_shotgun_killstreak_3_for_weapon_unlock", 1 );
                self.shouldzombiespawntags = 1;
            }
        }
        
        if ( turn_on_have_target_hud( "iw8_ar_t9fasthandling_mp" ) && var11 == "rifle" && var9 == 3 && !istrue( self.shouldreflect ) )
        {
            ref_12c3f( "t9_ch_global_assault_killstreak_3_for_weapon_unlock", 1 );
            self.shouldreflect = 1;
        }
        
        if ( turn_on_have_target_hud( "iw8_sm_t9fastfire_mp" ) && var11 == "smg" && isdefined( self.ref_12a89 ) && self.ref_12a89 == 2 && !istrue( self.shouldrespawn ) )
        {
            ref_12c3f( "t9_ch_global_smg_multikill_2_for_weapon_unlock", 1 );
            self.shouldrespawn = 1;
        }
        
        if ( var11 == "sniper" && var4 & 1 )
        {
            ref_12c3f( "t9_ch_global_kill_enemy_one_bullet_sniper_for_operator_mission", 1 );
        }
        
        if ( var11 == "throwingknife" || istrue( var21 ) )
        {
            ref_12c3f( "t9_ch_global_hatchet_kill_for_operator_mission", 1 );
        }
        
        if ( var1 == "iw8_me_t9loadout_mp" )
        {
            ref_12c3f( "t9_ch_global_knife_loadout_kill_for_operator_mission", 1 );
            ref_12c3f( "t9_ch_global_knife_loadout_kill_for_operator_mission_op2", 1 );
        }
        
        if ( var5 & 1073741824 )
        {
            if ( isdefined( self.ref_12a86 ) && isdefined( self.ref_12a86[ var2.basename ] ) && self.ref_12a86[ var2.basename ] == 2 && !istrue( self.should_enter_combat_after_checking_smoke_grenade ) )
            {
                if ( turn_on_have_target_hud( "iw8_me_t9sledgehammer_mp" ) )
                {
                    ref_12c3f( "t9_ch_global_knife_loadout_multikill_2_for_weapon_unlock", 1 );
                    self.should_enter_combat_after_checking_smoke_grenade = 1;
                }
            }
        }
        
        if ( var9 % 5 == 0 )
        {
            ref_12c3f( "t9_ch_global_killstreak_5_for_operator_unlock", 1 );
            ref_12c3f( "t9_ch_global_killstreak_5_for_operator_mission", 1 );
            ref_12c3f( "t9_ch_global_killstreak_5_for_operator_mission_op2", 1 );
        }
        
        if ( var10 )
        {
            ref_12c3f( "t9_ch_global_multikill_2_for_operator_mission", 1 );
        }
        
        if ( istrue( var14 ) )
        {
            ref_12c3f( "t9_ch_global_kill_with_scorestreak_for_operator_unlock", 1 );
            ref_12c3f( "t9_ch_global_kill_with_scorestreak_for_operator_mission", 1 );
        }
        
        if ( istrue( var12 ) && ( istrue( var25 ) || istrue( var26 ) ) )
        {
            ref_12c3f( "t9_ch_global_lethal_kill_with_quartermaster_or_restock_perk_for_operator_mission", 1 );
        }
        
        if ( var5 & 524288 )
        {
            ref_12c3f( "t9_ch_global_kill_detected_enemies_for_operator_unlock", 1 );
        }
        
        if ( var5 & 256 )
        {
            ref_12c3f( "t9_ch_global_finishing_move_kill_for_operator_unlock", 1 );
            ref_12c3f( "t9_ch_global_finishing_move_kill_for_operator_mission", 1 );
            
            if ( !istrue( self.show_balloon_deploy_hint ) && var5 & 1073741824 )
            {
                if ( !isdefined( self.ref_1440a ) )
                {
                    self.ref_1440a = 1;
                }
                else
                {
                    self.ref_1440a++;
                }
                
                if ( self.ref_1440a == 2 )
                {
                    if ( turn_on_have_target_hud( "iw8_me_t9wakizashi_mp" ) )
                    {
                        ref_12c3f( "t9_ch_global_knife_loadout_finishing_move_kill_2_for_weapon_unlock", 1 );
                        self.show_balloon_deploy_hint = 1;
                        self.ref_1440a = undefined;
                    }
                }
            }
        }
        
        if ( istrue( self.gulag ) )
        {
            ref_12c3f( "t9_ch_global_win_one_v_one_as_prisoner_for_operator_mission", 1 );
            ref_12c3f( "t9_ch_global_win_one_v_one_as_prisoner_for_operator_mission_op2", 1 );
        }
        
        if ( var4 & 512 || var4 & 1024 )
        {
            ref_12c3f( "t9_ch_global_kill_enemy_while_crouched_or_prone_for_operator_mission", 1 );
        }
        
        if ( var4 & 1048576 )
        {
            ref_12c3f( "t9_ch_global_headshots_for_operator_mission", 1 );
        }
        
        if ( var4 & 524288 )
        {
            ref_12c3f( "t9_ch_global_point_blank_kill_for_operator_mission", 1 );
        }
        
        if ( var4 & 262144 )
        {
            ref_12c3f( "t9_ch_global_longshot_kill_for_operator_mission", 1 );
        }
        
        if ( var4 & 4096 )
        {
            ref_12c3f( "t9_ch_global_kill_enemy_when_injured_for_operator_mission", 1 );
        }
        
        if ( var4 & 2097152 )
        {
            ref_12c3f( "t9_ch_global_kill_enemy_who_killed_teammate_for_operator_mission", 1 );
        }
        
        if ( istrue( var16 ) )
        {
            ref_12c3f( "t9_ch_global_satchel_charge_kill_for_operator_mission", 1 );
        }
        
        if ( istrue( var17 ) )
        {
            ref_12c3f( "t9_ch_global_molotov_kill_for_operator_mission", 1 );
        }
    }
    
    if ( var8 >= 8 )
    {
        if ( var7 )
        {
            if ( istrue( var17 ) )
            {
                ref_12c3f( "t9_ch_global_molotov_kill_for_operator_mission", 1 );
            }
            
            if ( var1 == "iw8_me_t9loadout_mp" )
            {
                ref_12c3f( "t9_ch_global_knife_loadout_kill_for_operator_mission_op3", 1 );
            }
            
            if ( istrue( var14 ) )
            {
                ref_12c3f( "t9_ch_global_kill_with_scorestreak_for_operator_mission_op2", 1 );
                
                if ( isdefined( var15 ) && ( var15 == "precision_airstrike" || var15 == "toma_strike" ) )
                {
                    ref_12c3f( "t9_ch_global_kill_with_scorestreak_strike_for_operator_mission", 1 );
                }
            }
            
            if ( var5 & 8388608 )
            {
                ref_12c3f( "t9_ch_global_kill_blinded_for_operator_mission", 1 );
            }
            
            if ( isdefined( self.waitillcanspawnclient ) && gettime() < self.waitillcanspawnclient + 20000 )
            {
                ref_12c3f( "t9_ch_global_kill_enemy_after_skydiving_for_operator_mission", 1 );
            }
            
            if ( var4 & 524288 )
            {
                ref_12c3f( "t9_ch_global_point_blank_kill_for_operator_mission_op2", 1 );
            }
            
            if ( istrue( var16 ) )
            {
                ref_12c3f( "t9_ch_global_satchel_charge_kill_for_operator_mission_op2", 1 );
            }
            
            if ( istrue( var19 ) || var1 == "equip_semtex" )
            {
                ref_12c3f( "t9_ch_global_semtex_kill_for_operator_mission", 1 );
            }
            
            if ( var11 == "rifle" && var4 & 1048576 )
            {
                ref_12c3f( "t9_ch_global_headshots_assault_for_operator_mission", 1 );
            }
            
            if ( isdefined( self.plantedsuperequip ) )
            {
                foreach ( var55 in self.plantedsuperequip )
                {
                    if ( isdefined( var55.origin ) && distancesquared( var55.origin, self.origin ) < 640000 )
                    {
                        ref_12c3f( "t9_ch_global_kill_near_non_lethal_field_upgrade_for_operator_mission", 1 );
                        break;
                    }
                }
            }
            
            if ( var5 & 536870912 )
            {
                ref_12c3f( "t9_ch_global_nightingale_kills_for_operator_mission", 1 );
            }
            
            if ( var5 & 4194304 )
            {
                ref_12c3f( "t9_ch_global_uav_kill_for_operator_mission", 1 );
                ref_12c3f( "t9_ch_global_uav_kill_for_operator_mission_op2", 1 );
            }
            
            if ( var11 == "throwingknife" || istrue( var21 ) )
            {
                ref_12c3f( "t9_ch_global_hatchet_kill_for_operator_mission_op2", 1 );
            }
            
            if ( var4 & 262144 )
            {
                ref_12c3f( "t9_ch_global_longshot_kill_for_operator_mission_op2", 1 );
            }
            
            if ( var5 & 512 )
            {
                ref_12c3f( "t9_ch_global_smoke_grenade_kill_for_operator_mission", 1 );
            }
            
            if ( var9 == 3 )
            {
                ref_12c3f( "t9_ch_global_killstreak_3_for_operator_mission", 1 );
            }
            
            if ( istrue( var20 ) )
            {
                ref_12c3f( "t9_ch_global_frag_grenade_kill_for_operator_mission", 1 );
            }
            
            if ( self.recentkillcount == 2 )
            {
                ref_12c3f( "t9_ch_global_multikill_2_for_operator_mission_op2", 1 );
            }
            
            if ( var5 & 256 )
            {
                ref_12c3f( "t9_ch_global_finishing_move_kill_for_operator_mission_op2", 1 );
            }
        }
        
        if ( var4 & 16384 )
        {
            ref_12c3f( "t9_ch_global_ekia_with_picked_up_weapon_for_operator_mission", 1 );
        }
        
        if ( var11 == "pistol" )
        {
            ref_12c3f( "t9_ch_global_ekia_pistol_for_operator_mission", 1 );
            ref_12c3f( "t9_ch_global_ekia_pistol_for_operator_mission_op2", 1 );
        }
        
        if ( var4 & 131072 )
        {
            ref_12c3f( "t9_ch_global_ekia_secondary_for_operator_mission", 1 );
        }
        
        if ( isdefined( self ) && isdefined( self.modifiers ) && istrue( self.modifiers[ "victimstunnedkill" ] ) )
        {
            ref_12c3f( "t9_ch_global_concussion_grenade_kill_for_operator_mission", 1 );
        }
        
        var57 = undefined;
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "getWeaponMenuCategory" ) )
        {
            var57 = scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "getWeaponMenuCategory" );
        }
        
        if ( isdefined( var57 ) && [[ var57 ]]( var2.basename ) == "weapon_tactical" )
        {
            ref_12c3f( "t9_ch_global_ekia_tactical_rifle_for_operator_mission", 1 );
            ref_12c3f( "t9_ch_global_ekia_tactical_rifle_for_operator_mission_op2", 1 );
        }
        
        if ( istrue( var34 ) )
        {
            ref_12c3f( "t9_ch_global_ekia_with_flak_jacket_perk_for_operator_mission", 1 );
        }
        
        if ( var11 == "smg" )
        {
            ref_12c3f( "t9_ch_global_ekia_smg_for_operator_mission", 1 );
        }
        
        if ( var24 & 2 )
        {
            ref_12c3f( "t9_ch_global_ekia_while_in_ground_vehicle_for_operator_mission", 1 );
        }
        
        if ( istrue( var30 ) )
        {
            ref_12c3f( "t9_ch_global_ekia_paranoia_or_high_alert_for_operator_mission_op2", 1 );
        }
        
        if ( var5 & 2048 )
        {
            ref_12c3f( "t9_ch_global_ekia_downed_for_operator_mission_op2", 1 );
        }
        
        if ( var11 == "spread" )
        {
            ref_12c3f( "t9_ch_global_ekia_shotgun_for_operator_mission_op2", 1 );
        }
        
        if ( istrue( var31 ) )
        {
            ref_12c3f( "t9_ch_global_ekia_tracker_for_operator_mission_op2", 1 );
        }
        
        if ( var11 == "sniper" )
        {
            ref_12c3f( "t9_ch_global_ekia_sniper_for_operator_mission", 1 );
        }
        
        var58 = self stopplayermusicstate();
        
        if ( var58 <= 35 && !issubstr( var3, "default_sniper_scope" ) )
        {
            ref_12c3f( "t9_ch_global_ekia_2x_or_greater_magnified_scope_attachment_for_operator_mission", 1 );
        }
        
        if ( istrue( var32 ) && var5 & 1 )
        {
            ref_12c3f( "t9_ch_global_ekia_under_enemy_detection_with_ghost_perk_for_operator_mission_op2", 1 );
        }
        
        var42 = undefined;
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "attachmentMap_toBase" ) )
        {
            var42 = scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "attachmentMap_toBase" );
        }
        
        foreach ( var44 in var2.attachments )
        {
            var45 = "";
            
            if ( isdefined( var42 ) )
            {
                var45 = [[ var42 ]]( var44 );
            }
            
            if ( isstartstr( var45, "thermal" ) )
            {
                ref_12c3f( "t9_ch_global_ekia_thermal_scope_for_operator_mission", 1 );
                break;
            }
        }
        
        if ( var11 == "mg" )
        {
            ref_12c3f( "t9_ch_global_ekia_lmg_for_operator_mission", 1 );
        }
        
        var61 = strtok( var3, "|" ).size;
        
        if ( var61 >= 5 )
        {
            ref_12c3f( "t9_ch_global_ekia_5_or_more_attachments_for_operator_mission", 1 );
        }
        
        if ( var24 & 4 )
        {
            ref_12c3f( "t9_ch_global_ekia_while_in_aerial_vehicle_for_operator_mission", 1 );
        }
    }
    
    if ( var11 == "sniper" )
    {
        ref_12c3f( "t9_ch_global_ekia_sniper_for_operator_unlock", 1 );
    }
    
    if ( var11 == "spread" )
    {
        ref_12c3f( "t9_ch_global_ekia_shotgun_for_operator_mission", 1 );
    }
    
    if ( var11 == "rifle" )
    {
        ref_12c3f( "t9_ch_global_ekia_assault_for_operator_mission", 1 );
    }
    
    if ( var5 & 131072 )
    {
        ref_12c3f( "t9_ch_global_ekia_with_silenced_weapons_for_operator_mission", 1 );
    }
    
    if ( var5 & 16777216 )
    {
        ref_12c3f( "t9_ch_global_ekia_enemies_gas_mine_or_gas_grenade_for_operator_mission", 1 );
    }
    
    if ( var5 & 8388608 )
    {
        ref_12c3f( "t9_ch_global_ekia_blinded_for_operator_mission", 1 );
    }
    
    if ( var5 & 4096 )
    {
        ref_12c3f( "t9_ch_global_ekia_while_in_vehicle_for_operator_mission", 1 );
    }
    
    if ( var5 & 2048 )
    {
        ref_12c3f( "t9_ch_global_ekia_downed_for_operator_mission", 1 );
    }
    
    if ( istrue( var27 ) || istrue( var28 ) )
    {
        ref_12c3f( "t9_ch_global_ekia_with_tac_mask_or_battle_hardened_perk_for_operator_mission", 1 );
    }
    
    if ( istrue( var29 ) )
    {
        ref_12c3f( "t9_ch_global_ekia_cold_blooded_for_operator_mission", 1 );
    }
    
    if ( istrue( var30 ) )
    {
        ref_12c3f( "t9_ch_global_ekia_paranoia_or_high_alert_for_operator_mission", 1 );
    }
    
    if ( istrue( var31 ) )
    {
        ref_12c3f( "t9_ch_global_ekia_tracker_for_operator_mission", 1 );
    }
    
    if ( istrue( var32 ) && var5 & 1 )
    {
        ref_12c3f( "t9_ch_global_ekia_under_enemy_detection_with_ghost_perk_for_operator_mission", 1 );
    }
    
    if ( var8 >= 8 )
    {
        if ( var7 )
        {
            if ( istrue( var17 ) )
            {
                ref_12c3f( "t9_ch_global_molotov_kill_for_operator_mission_op2", 1 );
            }
        }
        
        if ( var5 & 1073741824 )
        {
            if ( !isdefined( self.ref_11bc2 ) )
            {
                self.ref_11bc2 = 1;
            }
            else
            {
                self.ref_11bc2++;
            }
            
            if ( turn_on_have_target_hud( "iw8_me_t9etool_mp" ) && self.ref_11bc2 == 3 && !istrue( self.shouldrecorddamagestats ) )
            {
                ref_12c3f( "t9_ch_global_knife_loadout_killstreak_3_for_weapon_unlock", 1 );
                self.shouldrecorddamagestats = 1;
            }
        }
        
        if ( turn_on_have_target_hud( "iw8_me_t9machete_mp" ) && var4 & 4 && !istrue( self.shouldspawndropscommon ) )
        {
            ref_12c3f( "t9_ch_global_backstabber_kill_for_weapon_unlock", 1 );
            self.shouldspawndropscommon = 1;
        }
        
        if ( turn_on_have_target_hud( "iw8_sn_t9crossbow_mp" ) && var4 & 1 && isdefined( var3 ) && ( var3 == "" || var3 == "default_sniper_scope" ) && !istrue( self.shouldplayerovertimedialog ) )
        {
            if ( !isdefined( self.ref_1202c ) )
            {
                self.ref_1202c = 1;
            }
            else
            {
                self.ref_1202c++;
            }
            
            if ( self.ref_1202c >= 3 )
            {
                ref_12c3f( "t9_ch_global_kill_enemy_one_bullet_no_attachments_3_for_weapon_unlock", 1 );
                self.shouldplayerovertimedialog = 1;
            }
        }
        
        if ( turn_on_have_target_hud( "iw8_sn_t9cannon_mp" ) && var11 == "sniper" && var4 & 262144 && !istrue( self.shouldspawnloot ) )
        {
            if ( !isdefined( self.ref_13dbf ) )
            {
                self.ref_13dbf = 0;
            }
            
            self.ref_13dbf++;
            
            if ( self.ref_13dbf >= 2 )
            {
                ref_12c3f( "t9_ch_global_longshot_kill_sniper_2_for_weapon_unlock", 1 );
                self.shouldspawnloot = 1;
            }
        }
    }
    
    if ( var8 >= 9 )
    {
        if ( var7 )
        {
            if ( turn_on_have_target_hud( "iw8_me_t9ballisticknife_mp" ) && !isdefined( self.chopper_watch_death ) )
            {
                if ( var4 & 1 )
                {
                    self.ref_1202b = 1;
                }
                
                if ( istrue( self.ref_1202b ) && isdefined( self.ref_11bc2 ) && self.ref_11bc2 > 0 )
                {
                    self.chopper_watch_death = 1;
                    ref_12c3f( "t9_ch_global_kill_enemy_one_bullet_and_melee_weapon_kill_1life_for_weapon_unlock_s3", 1 );
                }
            }
            
            if ( var11 == "smg" && turn_on_have_target_hud( "iw8_sm_t9accurate_mp" ) && !isdefined( self.watchspawninput ) )
            {
                if ( !isdefined( self.ref_1341b ) )
                {
                    self.ref_1341b = 1;
                }
                else
                {
                    self.ref_1341b++;
                }
                
                if ( self.ref_1341b == 3 )
                {
                    self.watchspawninput = 1;
                    ref_12c3f( "t9_ch_global_smg_killstreak_3_for_weapon_unlock_s3", 1 );
                }
            }
            
            if ( var11 == "rifle" && turn_on_have_target_hud( "iw8_ar_t9slowhandling_mp" ) )
            {
                if ( !isdefined( self.pendingtimer ) && var4 & 1048576 )
                {
                    if ( !isdefined( self.cargo_truck_initomnvars ) )
                    {
                        self.cargo_truck_initomnvars = 1;
                    }
                    else
                    {
                        self.cargo_truck_initomnvars++;
                    }
                    
                    if ( self.cargo_truck_initomnvars == 2 )
                    {
                        self.pendingtimer = 1;
                        ref_12c3f( "t9_ch_global_ar_headsots_2_for_weapon_unlock_s3", 1 );
                    }
                }
            }
            
            if ( turn_on_have_target_hud( "iw8_ar_t9fastburst_mp" ) )
            {
                var57 = undefined;
                
                if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "getWeaponMenuCategory" ) )
                {
                    var57 = scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "getWeaponMenuCategory" );
                }
                
                if ( !isdefined( self.playerzombiesetradar ) && isdefined( var57 ) && [[ var57 ]]( var2.basename ) == "weapon_tactical" )
                {
                    if ( isdefined( self.ref_12a86 ) && isdefined( self.ref_12a86[ var2.basename ] ) && self.ref_12a86[ var2.basename ] == 2 )
                    {
                        self.playerzombiesetradar = 1;
                        ref_12c3f( "t9_ch_global_tr_multikill_2_for_weapon_unlock_s3", 1 );
                    }
                }
            }
            
            if ( turn_on_have_target_hud( "iw8_me_t9bat_mp" ) && var5 & 1073741824 && var5 & 4194304 && !isdefined( self.cinderblock_damage_monitor ) )
            {
                self.cinderblock_damage_monitor = 1;
                ref_12c3f( "t9_ch_global_melee_weapon_kill_detected_for_weapon_unlock_s3", 1 );
            }
        }
        
        if ( turn_on_have_target_hud( "iw8_pi_t9fullauto_mp" ) && var11 == "pistol" && !isdefined( self.ref_127d6 ) )
        {
            if ( !isdefined( self.ref_1237a ) )
            {
                self.ref_1237a = 1;
            }
            else
            {
                self.ref_1237a++;
            }
            
            if ( self.ref_1237a == 5 )
            {
                self.ref_127d6 = 1;
                ref_12c3f( "t9_ch_global_pistol_ekia_5_for_weapon_unlock_s3", 1 );
            }
        }
        
        if ( var7 )
        {
            if ( var5 & 1073741824 )
            {
                ref_12c3f( "t9_ch_global_melee_weapon_kill_for_operator_mission_s3", 1 );
            }
            
            if ( isdefined( self.waitillcanspawnclient ) && gettime() < self.waitillcanspawnclient + 20000 )
            {
                ref_12c3f( "t9_ch_global_kill_enemy_after_skydiving_for_operator_mission_s3", 1 );
            }
            
            if ( var11 == "throwingknife" || istrue( var21 ) )
            {
                ref_12c3f( "t9_ch_global_hatchet_kill_for_operator_mission_s3", 1 );
            }
            
            if ( isdefined( self ) && isdefined( self.modifiers ) && istrue( self.modifiers[ "victimstunnedkill" ] ) )
            {
                ref_12c3f( "t9_ch_global_concussion_grenade_kill_for_operator_mission_s3", 1 );
            }
            
            if ( self.intel_guys % 3 == 0 )
            {
                ref_12c3f( "t9_ch_global_killstreak_shotgun_without_dying_for_operator_mission_s3", 1 );
            }
            
            if ( istrue( var12 ) && ( istrue( var25 ) || istrue( var26 ) ) )
            {
                ref_12c3f( "t9_ch_global_lethal_kill_with_quartermaster_or_restock_perk_for_operator_mission_s3", 1 );
            }
            
            if ( var11 == "rocketlauncher" )
            {
                ref_12c3f( "t9_ch_global_launcher_kill_or_destruction_for_operator_mission_s3", 1 );
            }
            
            if ( var11 == "rifle" && isdefined( self.ref_12a86 ) && isdefined( self.ref_12a86[ var2.basename ] ) && self.ref_12a86[ var2.basename ] >= 2 )
            {
                ref_12c3f( "t9_ch_global_assault_multikill_for_operator_mission_s3", 1 );
            }
            
            if ( istrue( var19 ) || var1 == "equip_semtex" )
            {
                ref_12c3f( "t9_ch_global_semtex_kill_for_operator_mission_s3", 1 );
            }
            
            if ( var5 & 4194304 )
            {
                ref_12c3f( "t9_ch_global_kill_while_friendly_uav_active_for_operator_mission_s3", 1 );
            }
            
            if ( istrue( var12 ) )
            {
                ref_12c3f( "t9_ch_global_lethal_kill_for_operator_mission_s3", 1 );
            }
            
            if ( var4 & 4 )
            {
                ref_12c3f( "t9_ch_global_finishing_move_kill_for_operator_mission_s3", 1 );
            }
            
            if ( istrue( var14 ) )
            {
                ref_12c3f( "t9_ch_global_kill_with_scorestreak_for_operator_mission_s3", 1 );
            }
            
            if ( var5 & 8388608 )
            {
                ref_12c3f( "t9_ch_global_kill_blinded_for_operator_mission_s3", 1 );
            }
            
            if ( var5 & 512 )
            {
                ref_12c3f( "t9_ch_global_smoke_grenade_kill_for_operator_mission_s3", 1 );
            }
            
            if ( istrue( var20 ) )
            {
                ref_12c3f( "t9_ch_global_frag_grenade_kill_for_operator_mission_s3", 1 );
            }
            
            if ( var5 & 4096 )
            {
                ref_12c3f( "t9_ch_global_kill_while_in_vehicle_for_operator_mission_s3", 1 );
                
                if ( scripts\cp_mp\utility\player_utility::isinvehicle() )
                {
                    var62 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver( self.vehicle, 1 );
                    
                    if ( isdefined( var62 ) && var62 != self )
                    {
                        ref_12c3f( var62, "t9_ch_global_passenger_kill_while_driving_for_operator_mission_s3", 1 );
                    }
                }
            }
            
            if ( var5 & 268435456 )
            {
                ref_12c3f( "t9_ch_global_kill_without_taking_damage_for_operator_mission_s3", 1 );
            }
        }
        
        if ( istrue( var35 ) || istrue( var36 ) )
        {
            ref_12c3f( "t9_ch_global_ekia_gung_ho_double_time_for_operator_mission_s3", 1 );
        }
        
        if ( isdefined( var2 ) && isdefined( var2.attachments ) )
        {
            var42 = undefined;
            
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "attachmentMap_toBase" ) )
            {
                var42 = scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "attachmentMap_toBase" );
            }
            
            foreach ( var44 in var2.attachments )
            {
                var45 = "";
                
                if ( isdefined( var42 ) )
                {
                    var45 = [[ var42 ]]( var44 );
                }
                
                if ( var11 == "smg" && var45 == "stockno" )
                {
                    ref_12c3f( "t9_ch_global_smg_ekia_no_stock_for_operator_mission_s3", 1 );
                }
                
                if ( var11 == "pistol" && issubstr( var45, "reflex" ) )
                {
                    ref_12c3f( "t9_ch_global_pistol_ekia_led_optic_for_operator_mission_s3", 1 );
                }
                
                if ( isstartstr( var45, "grip" ) )
                {
                    ref_12c3f( "t9_ch_global_grip_kill_for_operator_mission_s3", 1 );
                }
            }
        }
        
        if ( istrue( var34 ) )
        {
            ref_12c3f( "t9_ch_global_ekia_with_flak_jacket_perk_for_operator_mission_s3", 1 );
        }
        
        if ( var1 == "iw8_sn_t9crossbow_mp" || var1 == "iw8_la_t9launcher_mp" || var1 == "special_ballisticknife" )
        {
            ref_12c3f( "t9_ch_global_special_weapon_ekia_for_operator_mission_s3", 1 );
        }
        
        if ( var11 == "rifle" )
        {
            ref_12c3f( "t9_ch_global_ekia_assault_for_operator_mission_s3", 1 );
            
            if ( isdefined( var2 ) && isdefined( var2.attachments ) )
            {
                var42 = undefined;
                
                if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "attachmentMap_toBase" ) )
                {
                    var42 = scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "attachmentMap_toBase" );
                }
                
                foreach ( var44 in var2.attachments )
                {
                    var45 = "";
                    
                    if ( isdefined( var42 ) )
                    {
                        var45 = [[ var42 ]]( var44 );
                    }
                    
                    if ( isstartstr( var45, "xmag" ) || isstartstr( var45, "smag" ) || isstartstr( var45, "drum" ) )
                    {
                        ref_12c3f( "t9_ch_global_ar_kill_extended_mag_for_operator_mission_s3", 1 );
                    }
                }
            }
        }
        
        if ( var11 == "sniper" )
        {
            ref_12c3f( "t9_ch_global_ekia_sniper_for_operator_mission_s3", 1 );
        }
        
        var57 = undefined;
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "getWeaponMenuCategory" ) )
        {
            var57 = scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "getWeaponMenuCategory" );
            
            if ( isdefined( var57 ) && [[ var57 ]]( var2.basename ) == "weapon_tactical" )
            {
                var58 = self stopplayermusicstate();
                
                if ( var58 <= 35 && !issubstr( var3, "default_sniper_scope" ) )
                {
                    ref_12c3f( "t9_ch_global_tr_ekia_2x_scope_for_operator_mission_s3", 1 );
                }
            }
        }
        
        if ( istrue( var31 ) )
        {
            ref_12c3f( "t9_ch_global_ekia_tracker_for_operator_mission_s3", 1 );
        }
        
        if ( var11 == "mg" )
        {
            ref_12c3f( "t9_ch_global_ekia_lmg_for_operator_mission_s3", 1 );
            
            if ( isdefined( var2 ) && isdefined( var2.attachments ) )
            {
                var42 = undefined;
                
                if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "attachmentMap_toBase" ) )
                {
                    var42 = scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "attachmentMap_toBase" );
                }
                
                foreach ( var44 in var2.attachments )
                {
                    var45 = "";
                    
                    if ( isdefined( var42 ) )
                    {
                        var45 = [[ var42 ]]( var44 );
                    }
                    
                    var68 = tablelookup( "mp/attachmenttable.csv", 5, var45, 3 );
                    
                    if ( issubstr( var68, "DRUM" ) )
                    {
                        ref_12c3f( "t9_ch_global_smg_ekia_drum_magazine_for_operator_mission_s3", 1 );
                        break;
                    }
                }
            }
        }
        
        if ( var11 == "spread" )
        {
            if ( isdefined( var2 ) && isdefined( var2.attachments ) && isdefined( level.ref_132bd ) )
            {
                foreach ( var44 in var2.attachments )
                {
                    if ( isdefined( level.ref_132bd[ var44 ] ) )
                    {
                        ref_12c3f( "t9_ch_global_shotgun_ekia_wire_stock_for_operator_mission_s3", 1 );
                        break;
                    }
                }
            }
        }
        
        if ( var11 == "pistol" )
        {
            if ( var5 & 2048 )
            {
                ref_12c3f( "t9_ch_global_pistol_ekia_downed_for_operator_mission_s3", 1 );
            }
            
            if ( var2 hasattachment( "akimbo", 1 ) )
            {
                ref_12c3f( "t9_ch_global_pistol_dw_ekia_for_operator_mission_s3", 1 );
            }
            
            if ( isdefined( var2 ) && isdefined( var2.attachments ) && isdefined( level.ref_1237c ) )
            {
                foreach ( var44 in var2.attachments )
                {
                    if ( isdefined( level.ref_1237c[ var44 ] ) )
                    {
                        ref_12c3f( "t9_ch_global_pistol_ekia_led_optic_for_operator_mission_s3", 1 );
                        break;
                    }
                }
            }
        }
        
        if ( istrue( var29 ) )
        {
            ref_12c3f( "t9_ch_global_ekia_cold_blooded_for_operator_missions_s3", 1 );
        }
        
        if ( var4 & 16777216 )
        {
            ref_12c3f( "t9_ch_global_revenge_kill_for_operator_mission_s3", 1 );
        }
    }
    
    if ( var8 >= 10 )
    {
        if ( getdvarint( "scr_enable_br_satellite_hunt", 0 ) == 1 )
        {
            if ( var7 && update_objective_ownerclient( self.origin ) )
            {
                ref_12c3f( "t9_ch_global_eliminate_enemy_near_active_satlink_or_crashed_satellite_for_s4_event_wz", 1 );
            }
        }
        
        if ( var7 )
        {
            if ( turn_on_have_target_hud( "iw8_sm_t9spray_mp" ) && var11 == "smg" )
            {
                var74 = 1500;
                var75 = self method_87c5();
                var76 = var75 < var74;
                
                if ( !isdefined( self.ref_1283c ) && var76 )
                {
                    if ( !isdefined( self.ref_1341a ) )
                    {
                        self.ref_1341a = 1;
                    }
                    else
                    {
                        self.ref_1341a++;
                    }
                    
                    if ( self.ref_1341a == 3 )
                    {
                        ref_12c3f( "t9_ch_global_smg_kills_after_sprinting_for_weapon_unlock_s4", 1 );
                        self.ref_1283c = 1;
                        self.ref_1341a = undefined;
                    }
                }
            }
            
            if ( !isdefined( self.ref_139ca ) && turn_on_have_target_hud( "iw8_sn_t9accurate_mp" ) && var11 == "sniper" && var4 & 1048576 )
            {
                if ( !isdefined( self.ref_1343e ) )
                {
                    self.ref_1343e = 1;
                }
                else
                {
                    self.ref_1343e++;
                }
                
                if ( self.ref_1343e == 2 )
                {
                    ref_12c3f( "t9_ch_global_sniper_headshots_for_weapon_unlock_s4", 1 );
                    self.ref_139ca = 1;
                    self.ref_1343e = undefined;
                }
            }
            
            if ( turn_on_have_target_hud( "iw8_me_t9mace_mp" ) && !isdefined( self.ref_11a6b ) && var5 & 1073741824 && var4 & 256 )
            {
                ref_12c3f( "t9_ch_global_melee_weapon_kill_while_sliding_for_weapon_unlock_s4", 1 );
                self.ref_11a6b = 1;
            }
            
            if ( turn_on_have_target_hud( "iw8_sm_t9cqb_mp" ) && !isdefined( self.ref_12159 ) && var11 == "smg" )
            {
                if ( isdefined( self.ref_12a86 ) && isdefined( self.ref_12a86[ var2.basename ] ) && self.ref_12a86[ var2.basename ] == 2 )
                {
                    ref_12c3f( "t9_ch_global_smg_multikill_for_weapon_unlock_s4", 1 );
                    self.ref_12159 = 1;
                }
            }
        }
        
        if ( turn_on_have_target_hud( "iw8_sm_t9nailgun_mp" ) && !isdefined( self.ref_11e22 ) && useserverhud( var1 ) )
        {
            if ( !isdefined( self.ref_136d4 ) )
            {
                self.ref_136d4 = 1;
            }
            else
            {
                self.ref_136d4++;
            }
            
            if ( self.ref_136d4 == 5 )
            {
                ref_12c3f( "t9_ch_global_special_ekia_for_weapon_unlock_s4", 1 );
                self.ref_136d4 = undefined;
                self.ref_11e22 = 1;
            }
        }
        
        if ( var7 )
        {
            var77 = var4 & 524288;
            var78 = var11 == "spread";
            
            if ( var77 && var78 )
            {
                ref_12c3f( "t9_ch_global_shotgun_point_blank_kill_for_operator_mission_s4", 1 );
            }
            
            if ( isdefined( self.watch_for_player_enter_trigger ) )
            {
                var79 = gettime() - self.watch_for_player_enter_trigger < 10000;
                
                if ( istrue( var79 ) )
                {
                    ref_12c3f( "t9_ch_global_kill_after_stim_shot_for_operator_mission_s4", 1 );
                }
            }
            
            if ( var4 & 8 )
            {
                ref_12c3f( "t9_ch_global_kills_while_ads_for_operator_mission_s4", 1 );
            }
            
            if ( var4 & 1048576 )
            {
                if ( !isdefined( self.getanglesfacingorigin ) )
                {
                    self.getanglesfacingorigin = 0;
                }
                
                self.getanglesfacingorigin++;
                
                if ( self.getanglesfacingorigin == 3 )
                {
                    ref_12c3f( "t9_ch_global_headshots_in_one_game_for_operator_mission_s4", 1 );
                }
            }
            
            var80 = var11 == "sniper" || va_cluster_spawnpoint_valid( var2 );
            var81 = var4 & 1048576 && var4 & 262144;
            
            if ( var80 && var81 )
            {
                ref_12c3f( "t9_ch_global_sniper_or_tactical_longshot_headshots_for_operator_mission_s4", 1 );
            }
            
            if ( var5 & 1048576 )
            {
                ref_12c3f( "t9_ch_global_concussion_grenade_kill_for_operator_mission_s4", 1 );
            }
            
            if ( istrue( var12 ) )
            {
                if ( !isdefined( self.getarenaomnvarbitpackinginfo ) )
                {
                    self.getarenaomnvarbitpackinginfo = 0;
                }
                
                self.getarenaomnvarbitpackinginfo++;
                
                if ( self.getarenaomnvarbitpackinginfo == 3 )
                {
                    ref_12c3f( "t9_ch_global_lethal_kills_in_one_game_for_operator_mission_s4", 1 );
                }
            }
            
            if ( istrue( var19 ) || var1 == "equip_semtex" )
            {
                ref_12c3f( "t9_ch_global_semtex_kill_for_operator_mission_s4", 1 );
            }
            
            if ( istrue( var12 ) )
            {
                ref_12c3f( "t9_ch_global_lethal_kill_for_operator_mission_s4", 1 );
                
                if ( var25 )
                {
                    if ( !isdefined( self.weapon_xp_iw8_sh_dpapa12 ) )
                    {
                        self.weapon_xp_iw8_sh_dpapa12 = 1;
                    }
                    else
                    {
                        self.weapon_xp_iw8_sh_dpapa12++;
                    }
                    
                    if ( self.weapon_xp_iw8_sh_dpapa12 == 2 )
                    {
                        ref_12c3f( "t9_ch_global_two_lethal_kills_same_life_with_quartermaster_or_restock_perk_for_operator_mission_s4", 1 );
                    }
                }
            }
            
            if ( var4 & 8 )
            {
                ref_12c3f( "t9_ch_global_kills_while_ads_for_operator_mission_s4", 1 );
            }
            
            if ( !isdefined( self.getanimsforplanefacing ) )
            {
                self.getanimsforplanefacing = var1;
            }
            else if ( self.getanimsforplanefacing != var1 )
            {
                ref_12c3f( "t9_ch_global_kills_from_different_weapons_without_dying_for_operator_mission_s4", 1 );
            }
            
            var80 = var11 == "sniper" || va_cluster_spawnpoint_valid( var2 );
            var81 = var4 & 1048576 && var4 & 262144;
            
            if ( var80 && var81 )
            {
                ref_12c3f( "t9_ch_global_sniper_or_tactical_longshot_headshots_for_operator_mission_s4", 1 );
            }
            
            if ( var14 && getkillstreaknamefromweapon( var2 ) == "precision_airstrike" )
            {
                ref_12c3f( "t9_ch_global_kill_with_scorestreak_strike_for_operator_mission_s4", 1 );
            }
            
            if ( var4 & 256 )
            {
                ref_12c3f( "t9_ch_global_sliding_kill_for_operator_mission_s4", 1 );
            }
            
            if ( var5 & 1073741824 || var1 == "iw8_me_t9ballisticknife_mp" )
            {
                ref_12c3f( "t9_ch_global_melee_weapon_or_ballistic_knife_kill_for_operator_mission_s4", 1 );
            }
            
            if ( !isdefined( self.ref_145a3 ) )
            {
                self.ref_145a3 = [];
            }
            
            self.ref_145a3[ var1 ] = 1;
            
            if ( self.ref_145a3.size == 6 && !isdefined( self.lightsreset ) )
            {
                self.lightsreset = 1;
                ref_12c3f( "t9_ch_global_kill_with_different_weapons_for_operator_mission_s4", 1 );
            }
            
            if ( isdefined( self.player_equip_primary ) && self.recentkillcount >= 2 && weaponclass( self.player_equip_primary ) == "smg" && var2 == self.player_equip_primary )
            {
                ref_12c3f( "t9_ch_global_smg_multikill_for_operator_mission_s4", 1 );
            }
            
            if ( istrue( var12 ) && isdefined( self.recentkillcount ) && self.recentkillcount >= 2 )
            {
                ref_12c3f( "t9_ch_global_lethal_kills_from_same_thrown_in_one_game_for_operator_mission_s4", 1 );
            }
            
            if ( var5 & 262144 )
            {
                ref_12c3f( "t9_ch_global_kill_with_penetrated_bullet_for_operator_mission_s4", 1 );
            }
            
            if ( var4 & 524288 )
            {
                ref_12c3f( "t9_ch_global_point_blank_kill_for_operator_mission_s4", 1 );
            }
            
            if ( var4 & 8 && isdefined( var2 ) && isdefined( var2.attachments ) )
            {
                var42 = undefined;
                
                if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "attachmentMap_toBase" ) )
                {
                    var42 = scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "attachmentMap_toBase" );
                }
                
                foreach ( var44 in var2.attachments )
                {
                    var45 = "";
                    
                    if ( isdefined( var42 ) )
                    {
                        var45 = [[ var42 ]]( var44 );
                    }
                    
                    if ( issubstr( var45, "reflex" ) )
                    {
                        ref_12c3f( "t9_ch_global_ads_kill_with_led_optic_for_operator_mission_s4", 1 );
                        break;
                    }
                }
            }
            
            if ( var14 )
            {
                if ( var15 == "toma_strike" )
                {
                    ref_12c3f( "t9_ch_global_napalm_strike_or_cluster_strike_kill_for_operator_mission_s4", 1 );
                }
                
                if ( var15 == "toma_strike" || var15 == "precision_airstrike" || var15 == "cruise_predator" || var15 == "chopper_gunner" || var15 == "fuel_airstrike" || var15 == "gunship" )
                {
                    ref_12c3f( "t9_ch_global_aerial_scorestreak_kill_for_operator_mission_s4", 1 );
                }
            }
            
            if ( var4 & 1048576 && va_cluster_spawnpoint_valid( var2 ) )
            {
                ref_12c3f( "t9_ch_global_tactical_headshots_for_operator_mission_s4", 1 );
            }
            
            if ( var5 & 16777216 )
            {
                ref_12c3f( "t9_ch_global_gas_kill_for_operator_mission_s4", 1 );
            }
            
            if ( var11 == "rocketlauncher" )
            {
                ref_12c3f( "t9_ch_global_launcher_kill_or_destruction_for_operator_mission_s4", 1 );
            }
            
            if ( var4 & 524288 && var11 == "pistol" && isdefined( self.lastkilledplayer ) )
            {
                var84 = vectornormalize( self.origin - self.lastkilledplayer.origin );
                var85 = anglestoforward( self.lastkilledplayer getplayerangles( 1 ) );
                var86 = vectordot( var84, var85 );
                
                if ( var86 < 0 )
                {
                    ref_12c3f( "t9_ch_global_pistol_point_blank_kill_from_behind_for_operator_mission_s4", 1 );
                }
            }
            
            if ( self.killcountthislife == 5 )
            {
                ref_12c3f( "t9_ch_global_killstreak_5_for_operator_mission_s4", 1 );
            }
        }
        
        if ( isdefined( var2 ) && var2.inventorytype == "primary" && !( var4 & 131072 ) )
        {
            ref_12c3f( "t9_ch_global_primary_weapon_ekia_operator_mission_s4", 1 );
        }
        
        if ( istrue( var34 ) )
        {
            ref_12c3f( "t9_ch_global_ekia_with_flak_jacket_perk_for_operator_mission_s4", 1 );
        }
        
        if ( isdefined( var2 ) && weaponissemiauto( var2 ) )
        {
            ref_12c3f( "t9_ch_global_semi_auto_ekia_for_operator_mission_s4", 1 );
        }
        
        var87 = "pistolgrip03";
        var88 = isdefined( var3 ) && issubstr( var3, var87 );
        
        if ( var88 )
        {
            ref_12c3f( "t9_ch_global_ekia_with_speed_tape_attachment_for_operator_mission_s4", 1 );
        }
        
        if ( var11 == "mg" )
        {
            ref_12c3f( "t9_ch_global_lmg_ekia_for_operator_mission_s4", 1 );
        }
        
        if ( isdefined( var2 ) && isdefined( var2.attachments ) )
        {
            var42 = undefined;
            
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "attachmentMap_toBase" ) )
            {
                var42 = scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "attachmentMap_toBase" );
            }
            
            foreach ( var44 in var2.attachments )
            {
                var45 = "";
                
                if ( isdefined( var42 ) )
                {
                    var45 = [[ var42 ]]( var44 );
                }
                
                if ( isstartstr( var45, "laser" ) )
                {
                    ref_12c3f( "t9_ch_global_ekia_with_laser_body_attachment_for_operator_mission_s4", 1 );
                    break;
                }
            }
        }
        
        if ( var4 & 131072 )
        {
            ref_12c3f( "t9_ch_global_ekia_secondary_for_operator_mission_s4", 1 );
        }
        
        if ( var11 == "spread" )
        {
            ref_12c3f( "t9_ch_global_shotgun_ekia_for_operator_mission_s4", 1 );
        }
        
        if ( var11 == "smg" && var5 & 131072 )
        {
            ref_12c3f( "t9_ch_global_smg_ekia_with_silenced_weapons_for_operator_mission_s4", 1 );
        }
        
        if ( turret_struct( var2 ) )
        {
            ref_12c3f( "t9_ch_global_assault_ekia_for_operator_mission_s4", 1 );
        }
        
        if ( isdefined( var2 ) && weaponinventorytype( var2 ) == "primary" && var1 != "iav_weapon_mp" && var1 != "equip_pop_rocket" && ( weaponburstcount( var1 ) > 0 || var1 == "iw8_ar_anovember94_mp" ) )
        {
            ref_12c3f( "t9_ch_global_burst_fire_ekia_for_operator_mission_s4", 1 );
        }
    }
    
    if ( var8 >= 11 )
    {
        if ( var7 )
        {
            if ( turn_on_have_target_hud( "iw8_lm_t9fastfire_mp" ) && !isdefined( self.ref_11bd7 ) && var11 == "mg" )
            {
                if ( !isdefined( self.zombieloadout ) )
                {
                    self.zombieloadout = 1;
                    thread watchreloading( "MG82_challenge_progressed" );
                }
                else
                {
                    self.zombieloadout++;
                }
                
                if ( self.zombieloadout == 3 )
                {
                    ref_12c3f( "t9_ch_global_lmg_kill_x_without_reloading_for_weapon_unlock_s5", 1 );
                    self notify( "MG82_challenge_progressed" );
                    self.ref_11bd7 = 1;
                }
            }
            
            if ( turn_on_have_target_hud( "iw8_ar_t9slowfire_mp" ) && !isdefined( self.force_group_thermites ) && turret_struct( var2 ) && var4 & 262144 )
            {
                ref_12c3f( "t9_ch_global_ar_longshot_kill_for_weapon_unlock_s5", 1 );
                self.force_group_thermites = 1;
            }
            
            if ( turn_on_have_target_hud( "iw8_pi_t9pistolshot_mp" ) && !isdefined( self.ref_11b1a ) && var11 == "pistol" && var4 & 1048576 )
            {
                ref_12c3f( "t9_ch_global_pistol_headshot_kill_for_weapon_unlock_s5", 1 );
                self.ref_11b1a = 1;
            }
            
            if ( turn_on_have_target_hud( "iw8_me_t9cane_mp" ) && !isdefined( self.get_actual_grenade_name ) && var5 & 1073741824 )
            {
                var91 = var5 & 1048576;
                var92 = var5 & 8388608;
                
                if ( var91 || var92 )
                {
                    ref_12c3f( "t9_ch_global_melee_weapon_kill_blinded_stunned_for_weapon_unlock_s5", 1 );
                    self.get_actual_grenade_name = 1;
                }
            }
            
            if ( turn_on_have_target_hud( "iw8_me_t9sai_mp" ) && !isdefined( self.ref_12e7a ) && var5 & 1073741824 && var5 & 268435456 )
            {
                ref_12c3f( "t9_ch_global_melee_weapon_kill_no_return_fire_for_weapon_unlock_s5", 1 );
                self.ref_12e7a = 1;
            }
        }
        
        if ( var7 )
        {
            if ( var5 & 536870912 )
            {
                ref_12c3f( "t9_ch_global_nightingale_kills_for_operator_mission_s5", 1 );
            }
            
            if ( istrue( var17 ) )
            {
                ref_12c3f( "t9_ch_global_molotov_kill_for_operator_mission_s5", 1 );
            }
            
            if ( var11 == "pistol" )
            {
                if ( !isdefined( self.ref_1237b ) )
                {
                    self.ref_1237b = 1;
                }
                else
                {
                    self.ref_1237b++;
                }
                
                if ( self.ref_1237b > 0 && self.ref_1237b % 3 == 0 )
                {
                    ref_12c3f( "t9_ch_global_pistol_killstreak_5_for_operator_mission_s5", 1 );
                }
            }
            
            if ( var5 & 1073741824 )
            {
                ref_12c3f( "t9_ch_global_melee_weapon_kill_for_operator_mission_s5", 1 );
            }
            
            if ( istrue( var12 ) )
            {
                ref_12c3f( "t9_ch_global_lethal_kill_for_operator_mission_s5", 1 );
            }
            
            if ( var4 & 1048576 && va_cluster_spawnpoint_valid( var2 ) )
            {
                ref_12c3f( "t9_ch_global_tactical_headshots_for_operator_mission_s5", 1 );
            }
            
            if ( var11 == "throwingknife" || istrue( var21 ) )
            {
                ref_12c3f( "t9_ch_global_hatchet_or_throwing_knife_kill_for_operator_mission_s5", 1 );
            }
            
            if ( var2.inventorytype == "primary" && !( var4 & 131072 ) )
            {
                if ( !isdefined( self.vip_questthink_iconposition ) )
                {
                    self.vip_questthink_iconposition = 1;
                }
                else
                {
                    self.vip_questthink_iconposition++;
                }
                
                if ( !isdefined( self.vip_removequestinstance ) )
                {
                    self.vip_removequestinstance = 1;
                }
                else
                {
                    self.vip_removequestinstance++;
                }
            }
            
            if ( var4 & 131072 )
            {
                if ( !isdefined( self.vip_respawnplayer ) )
                {
                    self.vip_respawnplayer = 1;
                }
                else
                {
                    self.vip_respawnplayer++;
                }
                
                if ( !isdefined( self.vipbot_movesup ) )
                {
                    self.vipbot_movesup = 1;
                }
                else
                {
                    self.vipbot_movesup++;
                }
            }
            
            if ( var12 )
            {
                if ( !isdefined( self.vip_playerremoved ) )
                {
                    self.vip_playerremoved = 1;
                }
                else
                {
                    self.vip_playerremoved++;
                }
            }
            
            if ( isdefined( self.vip_questthink_iconposition ) && isdefined( self.vip_respawnplayer ) && self.vip_questthink_iconposition > 0 && self.vip_respawnplayer > 0 )
            {
                self.vip_questthink_iconposition--;
                self.vip_respawnplayer--;
                ref_12c3f( "t9_ch_global_kill_primary_secondary_without_dying_for_operator_mission_s3", 1 );
                ref_12c3f( "t9_ch_global_kill_primary_secondary_without_dying_for_operator_mission_s5", 1 );
            }
            
            if ( isdefined( self.vip_removequestinstance ) && isdefined( self.vip_respawnplayer ) && isdefined( self.vip_playerremoved ) && self.vip_removequestinstance > 0 && self.vipbot_movesup > 0 && self.vip_playerremoved > 0 )
            {
                self.vip_removequestinstance--;
                self.vipbot_movesup--;
                self.vip_playerremoved--;
                ref_12c3f( "t9_ch_global_kill_primary_secondary_lethal_without_dying_for_operator_mission_s3", 1 );
                
                if ( var8 >= 12 )
                {
                    ref_12c3f( "t9_ch_global_kill_primary_secondary_lethal_without_dying_for_operator_mission_s6", 1 );
                    ref_12c3f( "t9_ch_global_primary_secondary_equipment_scorestreak_kill_in_single_game_s6", 1 );
                }
            }
            
            if ( var4 & 524288 )
            {
                ref_12c3f( "t9_ch_global_point_blank_kill_for_operator_mission_s5", 1 );
            }
            
            if ( var4 & 512 || var4 & 1024 )
            {
                ref_12c3f( "t9_ch_global_kill_enemy_while_crouched_or_prone_for_operator_mission_s5", 1 );
            }
            
            if ( var4 & 262144 )
            {
                ref_12c3f( "t9_ch_global_longshot_kill_for_operator_mission_s5", 1 );
            }
            
            if ( var14 && getkillstreaknamefromweapon( var2 ) == "precision_airstrike" )
            {
                ref_12c3f( "t9_ch_global_kill_with_scorestreak_strike_for_operator_mission_s5", 1 );
            }
            
            if ( istrue( var19 ) || var1 == "equip_semtex" )
            {
                ref_12c3f( "t9_ch_global_semtex_kill_for_operator_mission_s5", 1 );
            }
            
            if ( var11 == "rocketlauncher" )
            {
                ref_12c3f( "t9_ch_global_launcher_kill_or_destruction_for_operator_mission_s5", 1 );
            }
            
            if ( turret_struct( var2 ) )
            {
                if ( isdefined( self.ref_12a86 ) && isdefined( self.ref_12a86[ var2.basename ] ) && self.ref_12a86[ var2.basename ] == 2 )
                {
                    ref_12c3f( "t9_ch_global_ar_multikill_for_operator_mission_s5", 1 );
                }
            }
            
            if ( var15 == "toma_strike" || var15 == "precision_airstrike" || var15 == "cruise_predator" || var15 == "chopper_gunner" || var15 == "fuel_airstrike" || var15 == "gunship" )
            {
                ref_12c3f( "t9_ch_global_kill_with_aerial_scorestreak_or_killstreak_for_operator_mission_s5", 1 );
            }
            
            if ( var5 & 1073741824 || var1 == "iw8_me_t9ballisticknife_mp" )
            {
                ref_12c3f( "t9_ch_global_melee_weapon_or_ballistic_knife_kill_for_operator_mission_s5", 1 );
            }
            
            if ( self.killcountthislife == 3 )
            {
                ref_12c3f( "t9_ch_common_opbundle_01_objective_2", 1 );
            }
            
            if ( var4 & 1048576 )
            {
                ref_12c3f( "t9_ch_common_opbundle_02_objective_2", 1 );
            }
            
            if ( isdefined( self.recentkillcount ) && self.recentkillcount == 2 )
            {
                ref_12c3f( "t9_ch_common_opbundle_02_objective_3", 1 );
            }
            
            if ( var12 )
            {
                ref_12c3f( "t9_ch_common_opbundle_03_objective_3", 1 );
            }
            
            if ( self.killcountthislife == 5 )
            {
                ref_12c3f( "t9_ch_common_opbundle_03_objective_4", 1 );
            }
        }
        
        if ( var11 == "smg" )
        {
            ref_12c3f( "t9_ch_global_smg_ekia_no_stock_for_operator_mission_s5", 1 );
        }
        
        if ( istrue( var31 ) )
        {
            ref_12c3f( "t9_ch_global_ekia_tracker_for_operator_mission_s5", 1 );
        }
        
        if ( turret_struct( var2 ) )
        {
            ref_12c3f( "t9_ch_global_assault_ekia_for_operator_mission_s5", 1 );
        }
        
        if ( var5 & 2048 )
        {
            ref_12c3f( "t9_ch_global_ekia_downed_for_operator_mission_s5", 1 );
        }
        
        if ( istrue( var30 ) )
        {
            ref_12c3f( "t9_ch_global_ekia_paranoia_or_high_alert_for_operator_mission_s5", 1 );
        }
        
        var42 = undefined;
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "attachmentMap_toBase" ) )
        {
            var42 = scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "attachmentMap_toBase" );
        }
        
        foreach ( var44 in var2.attachments )
        {
            var45 = "";
            
            if ( isdefined( var42 ) )
            {
                var45 = [[ var42 ]]( var44 );
            }
            
            if ( isstartstr( var45, "thermal" ) )
            {
                ref_12c3f( "t9_ch_global_ekia_thermal_scope_for_operator_mission_s5", 1 );
            }
            
            if ( var11 == "spread" && isstartstr( var45, "stockno" ) )
            {
                ref_12c3f( "t9_ch_global_shotgun_ekia_no_stock_for_operator_mission_s5", 1 );
            }
        }
        
        if ( istrue( var29 ) )
        {
            ref_12c3f( "t9_ch_global_ekia_cold_blooded_for_operator_mission_s5", 1 );
        }
        
        if ( istrue( var34 ) )
        {
            ref_12c3f( "t9_ch_global_ekia_with_flak_jacket_perk_for_operator_mission_s5", 1 );
        }
        
        if ( istrue( var32 ) && var5 & 1 )
        {
            ref_12c3f( "t9_ch_global_ekia_under_enemy_detection_with_ghost_perk_for_operator_mission_s5", 1 );
        }
        
        if ( var5 & 16777216 )
        {
            ref_12c3f( "t9_ch_global_ekia_enemies_gas_mine_or_gas_grenade_for_operator_mission_s5", 1 );
        }
        
        if ( useserverhud( var1 ) )
        {
            ref_12c3f( "t9_ch_global_special_weapon_ekia_for_operator_mission_s5", 1 );
        }
        
        if ( istrue( var35 ) || istrue( var36 ) )
        {
            ref_12c3f( "t9_ch_global_ekia_gung_ho_double_time_for_operator_mission_s5", 1 );
        }
        
        if ( var11 == "sniper" )
        {
            ref_12c3f( "t9_ch_global_sniper_ekia_for_operator_mission_s5", 1 );
        }
        
        if ( var11 == "mg" )
        {
            ref_12c3f( "t9_ch_global_lmg_ekia_for_operator_mission_s5", 1 );
        }
        
        var61 = strtok( var3, "|" ).size;
        
        if ( var61 >= 5 )
        {
            ref_12c3f( "t9_ch_global_ekia_5_or_more_attachments_for_operator_mission_s5", 1 );
        }
        
        var95 = 0;
        var96 = 0;
        var97 = 0;
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "perk", "hasPerk" ) )
        {
            var37 = scripts\cp_mp\utility\script_utility::getsharedfunc( "perk", "hasPerk" );
            var95 = self [[ var37 ]]( "specialty_quieter" );
            var96 = self [[ var37 ]]( "specialty_no_battle_chatter" );
            var97 = self [[ var37 ]]( "specialty_lightweight" );
        }
        
        var98 = var95 && var96 && var97;
        
        if ( var98 )
        {
            ref_12c3f( "t9_ch_global_ekia_while_using_ninja_or_dead_silence_for_operator_mission_s5", 1 );
        }
        
        if ( var11 == "pistol" && var5 & 131072 )
        {
            ref_12c3f( "t9_ch_global_pistol_ekia_with_silenced_weapons_for_operator_mission_s5", 1 );
        }
        
        switch ( var1 )
        {
            case "iw8_sm_t9handling_mp":
            case "iw8_ar_t9mobility_mp":
                ref_12c3f( "t9_ch_common_opbundle_01_objective_1", 1 );
                break;
            case "iw8_ar_akilo47_mp":
            case "iw8_sh_t9pump_mp":
            case "iw8_sm_t9burst_mp":
            case "iw8_ar_t9damage_mp":
                ref_12c3f( "t9_ch_common_opbundle_02_objective_1", 1 );
                break;
            case "iw8_sm_t9heavy_mp":
            case "iw8_ar_t9standard_mp":
                ref_12c3f( "t9_ch_common_opbundle_03_objective_1", 1 );
                break;
        }
    }
    
    if ( var8 >= 12 )
    {
        if ( var7 )
        {
            if ( turn_on_have_target_hud( "iw8_sm_t9semiauto_mp" ) && !isdefined( self.ref_13ad4 ) && var11 == "smg" && var4 & 1048576 )
            {
                if ( !isdefined( self.ref_13419 ) )
                {
                    self.ref_13419 = 0;
                }
                
                self.ref_13419++;
                
                if ( self.ref_13419 == 2 )
                {
                    ref_12c3f( "t9_ch_global_smg_headshot_kills_for_weapon_unlock_s6", 1 );
                    self.ref_13ad4 = 1;
                }
            }
            
            if ( turn_on_have_target_hud( "iw8_ar_t9british_mp" ) && !isdefined( self.monitoraveragevelocities ) && isdefined( var2 ) && turret_struct( var2 ) )
            {
                if ( isdefined( self.ref_12a86 ) && isdefined( self.ref_12a86[ var2.basename ] ) && self.ref_12a86[ var2.basename ] == 2 )
                {
                    ref_12c3f( "t9_ch_global_ar_multikill_for_weapon_unlock_s6", 1 );
                    self.monitoraveragevelocities = 1;
                }
            }
            
            var99 = var2.inventorytype == "primary" && !( var4 & 131072 );
            var100 = var4 & 131072;
            var101 = !( var5 & 1073741824 );
            
            if ( ( var99 || var100 ) && var101 )
            {
                if ( !isdefined( self.ref_12a0c ) )
                {
                    self.ref_12a0c = 0;
                }
                
                self.ref_12a0c++;
            }
            
            if ( var12 )
            {
                if ( !isdefined( self.numnonrallyvehicles ) )
                {
                    self.numnonrallyvehicles = 0;
                }
                
                self.numnonrallyvehicles++;
            }
            
            if ( turn_on_have_target_hud( "iw8_me_t9battleaxe_mp" ) && !isdefined( self.chooseanim_vehicleturret ) )
            {
                if ( isdefined( self.ref_11bc2 ) && self.ref_11bc2 > 0 && isdefined( self.numnonrallyvehicles ) && self.numnonrallyvehicles > 0 && isdefined( self.ref_12a0c ) && self.ref_12a0c > 0 )
                {
                    ref_12c3f( "t9_ch_global_kills_by_gun_and_melee_weapon_and_lethal_same_life_for_weapon_unlock_s6", 1 );
                    self.chooseanim_vehicleturret = 1;
                }
            }
            
            if ( turn_on_have_target_hud( "iw8_me_t9coldwar_mp" ) && !isdefined( self.setteamlastzombietime ) )
            {
                if ( var11 == "throwingknife" || istrue( var21 ) || var1 == "equip_throwing_knife" )
                {
                    self.ref_13b5b = 1;
                }
                
                if ( isdefined( self.ref_11bc2 ) && self.ref_11bc2 >= 0 && istrue( self.ref_13b5b ) )
                {
                    ref_12c3f( "t9_ch_global_melee_kill_plus_hatchet_or_throwing_kill_single_life_for_weapon_unlock_s6", 1 );
                    self.setteamlastzombietime = 1;
                }
            }
            
            if ( turn_on_have_target_hud( "iw8_sm_t9season6_mp" ) && !isdefined( self.waitingforteammaterevive ) )
            {
                if ( var11 == "smg" && var4 & 8 )
                {
                    if ( !isdefined( self.ref_13418 ) )
                    {
                        self.ref_13418 = 0;
                    }
                    
                    self.ref_13418++;
                    
                    if ( self.ref_13418 == 3 )
                    {
                        ref_12c3f( "t9_ch_global_smg_ads_x_kills_for_weapon_unlock_s6", 1 );
                        self.waitingforteammaterevive = 1;
                    }
                }
            }
            
            if ( turn_on_have_target_hud( "iw8_sh_t9leveraction_mp" ) && !isdefined( self.trial_targs_combo ) )
            {
                if ( var11 == "spread" && var4 & 524288 )
                {
                    if ( !isdefined( self.ref_132bc ) )
                    {
                        self.ref_132bc = 0;
                    }
                    
                    self.ref_132bc++;
                    
                    if ( self.ref_132bc == 2 )
                    {
                        ref_12c3f( "t9_ch_global_shotgun_point_blank_kills_for_weapon_unlock_s6", 1 );
                        self.trial_targs_combo = 1;
                    }
                }
            }
            
            if ( turn_on_have_target_hud( "iw8_ar_t9season6_mp" ) && !isdefined( self.send_notify_to_module_struct ) )
            {
                if ( turret_struct( var2 ) && isdefined( self.lastkilledplayer ) && make_c4_pick_up_interact( self, self.lastkilledplayer ) )
                {
                    if ( !isdefined( self.cargo_truck_initcollision ) )
                    {
                        self.cargo_truck_initcollision = 0;
                    }
                    
                    self.cargo_truck_initcollision++;
                    
                    if ( self.cargo_truck_initcollision == 3 )
                    {
                        ref_12c3f( "t9_ch_global_ar_kill_enemy_at_lower_elevation_for_weapon_unlock_s6", 1 );
                        self.send_notify_to_module_struct = 1;
                    }
                }
            }
        }
        
        if ( var7 )
        {
            if ( var12 )
            {
                ref_12c3f( "t9_ch_global_lethal_kill_for_operator_mission_s6", 1 );
            }
            
            if ( isdefined( self.getanglesfacingorigin ) && self.getanglesfacingorigin == 2 )
            {
                ref_12c3f( "t9_ch_global_two_headshots_same_game_for_operator_mission_s6", 1 );
            }
            
            if ( var9 == 5 )
            {
                ref_12c3f( "t9_ch_global_killstreak_5_for_operator_mission_s6", 1 );
                ref_12c3f( "t9_ch_common_opbundle_05_objective_2", 1 );
            }
            
            if ( var9 == 3 )
            {
                ref_12c3f( "t9_ch_common_opbundle_06_objective_3", 1 );
            }
            
            if ( isdefined( var2 ) && isdefined( var2.classname ) && var2.classname == "grenade" )
            {
                ref_12c3f( "t9_ch_global_explosive_kills_for_operator_mission_s6", 1 );
                ref_12c3f( "t9_ch_common_opbundle_06_objective_2", 1 );
            }
            
            if ( isdefined( self.cargo_truck_mg_addgunnerdamagemod ) && self.cargo_truck_mg_addgunnerdamagemod == 3 )
            {
                ref_12c3f( "t9_ch_global_ar_killstreak_3_for_operator_mission_s6", 1 );
            }
            
            if ( self.recentkillcount >= 2 )
            {
                ref_12c3f( "t9_ch_global_kills_while_on_streak_for_operator_mission_s6", 1 );
            }
            
            if ( istrue( var2.ref_12cc1 ) )
            {
                ref_12c3f( "t9_ch_global_supplypod_kill_for_operator_mission_s6", 1 );
            }
            
            if ( var5 & 268435456 )
            {
                ref_12c3f( "t9_ch_global_kill_without_taking_damage_for_operator_mission_s6", 1 );
                ref_12c3f( "t9_ch_common_opbundle_07_objective_2", 1 );
                var95 = 0;
                var96 = 0;
                var97 = 0;
                
                if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "perk", "hasPerk" ) )
                {
                    var37 = scripts\cp_mp\utility\script_utility::getsharedfunc( "perk", "hasPerk" );
                    var95 = self [[ var37 ]]( "specialty_quieter" );
                    var96 = self [[ var37 ]]( "specialty_no_battle_chatter" );
                    var97 = self [[ var37 ]]( "specialty_lightweight" );
                }
                
                var98 = var95 && var96 && var97;
                
                if ( var98 )
                {
                    ref_12c3f( "t9_ch_global_ninja_kill_without_taking_damage_for_operator_mission_s6", 1 );
                }
            }
            
            if ( var4 & 1048576 )
            {
                ref_12c3f( "t9_ch_global_headshots_for_operator_mission_s6", 1 );
                ref_12c3f( "t9_ch_common_opbundle_04_objective_3", 1 );
            }
            
            if ( isdefined( self.player_equip_primary ) && self.recentkillcount >= 2 && weaponclass( self.player_equip_primary ) == "smg" && var2 == self.player_equip_primary )
            {
                ref_12c3f( "t9_ch_global_smg_multikill_for_operator_mission_s6", 1 );
            }
            
            if ( var11 == "smg" && var4 & 16 )
            {
                if ( isdefined( var2 ) && isdefined( var2.attachments ) )
                {
                    var42 = undefined;
                    
                    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "attachmentMap_toBase" ) )
                    {
                        var42 = scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "attachmentMap_toBase" );
                    }
                    
                    foreach ( var44 in var2.attachments )
                    {
                        var45 = "";
                        
                        if ( isdefined( var42 ) )
                        {
                            var45 = [[ var42 ]]( var44 );
                        }
                        
                        if ( isstartstr( var45, "laser" ) )
                        {
                            ref_12c3f( "t9_ch_global_smg_hipfire_laser_attachment_ekia_for_operator_mission_s6", 1 );
                            break;
                        }
                    }
                }
            }
            
            if ( var5 & 262144 )
            {
                ref_12c3f( "t9_ch_global_kill_through_wall_for_operator_mission_s6", 1 );
            }
            
            if ( var14 && getkillstreaknamefromweapon( var2 ) == "toma_strike" )
            {
                ref_12c3f( "t9_ch_global_napalm_strike_or_cluster_strike_kill_for_operator_mission_s6", 1 );
            }
            
            if ( var4 & 512 || var4 & 1024 )
            {
                ref_12c3f( "t9_ch_global_kill_enemy_while_crouched_or_prone_for_operator_mission_s6", 1 );
            }
            
            if ( var5 & 16777216 )
            {
                ref_12c3f( "t9_ch_global_ekia_enemies_gas_mine_or_gas_grenade_for_operator_mission_s6", 1 );
            }
            
            if ( isdefined( self.ref_142ad ) && var12 )
            {
                var104 = self.origin + ( 0, 0, 35 );
                
                if ( var4 & 1024 )
                {
                    var104 = self.origin + ( 0, 0, 17 );
                }
                
                var105 = scripts\engine\trace::ray_trace( self.ref_142ad.origin + ( 0, 0, 35 ), var104, undefined, undefined, undefined, 1 );
                
                if ( isdefined( var105[ "entity" ] ) && var105[ "entity" ] != self )
                {
                    ref_12c3f( "t9_ch_global_lethal_equipment_kills_on_unseen_targets_for_operator_mission_s6", 1 );
                }
            }
            
            if ( self.recentkillcount >= 3 )
            {
                ref_12c3f( "t9_ch_global_triple_kills_for_operator_mission_s6", 1 );
            }
            
            if ( isdefined( self.ref_142ad ) && !( var4 & 512 ) )
            {
                var104 = self.origin + ( 0, 0, 35 );
                
                if ( var4 & 1024 )
                {
                    var104 = self.origin + ( 0, 0, 17 );
                }
                
                var105 = scripts\engine\trace::ray_trace( var104, self.ref_142ad.origin + ( 0, 0, 35 ), undefined, undefined, undefined, 1 );
                
                if ( var105[ "fraction" ] < 1 )
                {
                    ref_12c3f( "t9_ch_global_kill_enemies_while_partially_covered_for_operator_mission_s6", 1 );
                }
            }
            
            if ( isdefined( self.watch_for_player_enter_trigger ) )
            {
                var79 = gettime() - self.watch_for_player_enter_trigger < 10000;
                
                if ( istrue( var79 ) )
                {
                    ref_12c3f( "t9_ch_global_three_or_more_kills_with_stim_shot_for_operator_mission_s6", 1 );
                }
            }
            
            if ( isdefined( self.plantedsuperequip ) )
            {
                foreach ( var55 in self.plantedsuperequip )
                {
                    if ( isdefined( var55.origin ) && distancesquared( var55.origin, self.origin ) < 640000 )
                    {
                        ref_12c3f( "t9_ch_global_kill_near_non_lethal_field_upgrade_for_operator_mission_s6", 1 );
                        break;
                    }
                }
            }
            
            if ( isdefined( self.ref_11bc1 ) && self.ref_11bc1 == 3 )
            {
                ref_12c3f( "t9_ch_global_three_melee_kills_in_single_game_for_operator_mission_s6", 1 );
            }
            
            if ( isdefined( self.attackerdata ) && isdefined( self.lastkilledplayer ) && isdefined( self.attackerdata[ self.lastkilledplayer.guid ] ) && isdefined( self.attackerdata[ self.lastkilledplayer.guid ].lasttimedamaged ) )
            {
                ref_12c3f( "t9_ch_global_kill_enemy_damage_you_for_operator_mission_s6", 1 );
            }
            
            if ( istrue( var20 ) )
            {
                ref_12c3f( "t9_ch_global_frag_grenade_kill_for_operator_mission_s6", 1 );
            }
            
            if ( var11 == "rocketlauncher" )
            {
                ref_12c3f( "t9_ch_global_launcher_kill_or_destruction_for_operator_mission_s6", 1 );
            }
            
            if ( isdefined( self.lastkilledplayer ) )
            {
                var108 = 3936.8;
                var109 = distance2d( self.origin, self.lastkilledplayer.origin );
                
                if ( var109 >= var108 )
                {
                    ref_12c3f( "t9_ch_global_kill_enemy_over_100m_away_for_operator_mission_s6", 1 );
                }
            }
        }
        
        ref_12c3f( "t9_ch_global_ekia_for_operator_mission_s6", 1 );
        
        if ( istrue( var27 ) || istrue( var28 ) )
        {
            ref_12c3f( "t9_ch_global_ekia_with_tac_mask_or_battle_hardened_perk_for_operator_mission_s6", 1 );
        }
        
        if ( isdefined( var2 ) && va_cluster_spawnpoint_valid( var2 ) )
        {
            ref_12c3f( "t9_ch_global_ekia_tactical_rifle_for_operator_mission_s6", 1 );
        }
        
        if ( isdefined( var2 ) && turret_struct( var2 ) )
        {
            ref_12c3f( "t9_ch_global_assault_ekia_for_operator_mission_s6", 1 );
        }
        
        switch ( level.disable_super_in_turret.name )
        {
            case "mini":
            case "":
                ref_12c3f( "t9_ch_global_ekia_single_life_elim_mode_for_operator_mission_s6", 1 );
                break;
            default:
                break;
        }
        
        if ( var11 == "smg" )
        {
            ref_12c3f( "t9_ch_global_smg_ekia_for_operator_mission_s6", 1 );
        }
        
        if ( var11 == "pistol" )
        {
            ref_12c3f( "t9_ch_global_pistol_ekia_for_operator_mission_for_operator_mission_s6", 1 );
        }
        
        if ( var4 & 131072 )
        {
            ref_12c3f( "t9_ch_global_ekia_secondary_for_operator_mission_s6", 1 );
        }
        
        if ( isdefined( var2 ) && isdefined( var2.attachments ) )
        {
            var42 = undefined;
            
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "attachmentMap_toBase" ) )
            {
                var42 = scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "attachmentMap_toBase" );
            }
            
            foreach ( var44 in var2.attachments )
            {
                var45 = "";
                
                if ( isdefined( var42 ) )
                {
                    var45 = [[ var42 ]]( var44 );
                }
                
                if ( isstartstr( var45, "xmag" ) || isstartstr( var45, "smag" ) || isstartstr( var45, "drum" ) )
                {
                    ref_12c3f( "t9_ch_global_ekia_extra_ammo_magazine_for_operator_mission_s6", 1 );
                }
            }
        }
        
        if ( var11 == "spread" )
        {
            ref_12c3f( "t9_ch_global_shotgun_ekia_for_operator_mission_s6", 1 );
        }
        
        if ( isdefined( var2 ) && unset_relic_focus_fire( var2 ) )
        {
            ref_12c3f( "t9_ch_global_ekia_full_auto_for_operator_mission_s6", 1 );
        }
        
        if ( var11 == "mg" )
        {
            ref_12c3f( "t9_ch_global_lmg_ekia_for_operator_mission_s6", 1 );
        }
        
        if ( istrue( var30 ) )
        {
            ref_12c3f( "t9_ch_global_ekia_paranoia_or_high_alert_for_operator_mission_s6", 1 );
        }
        
        switch ( var1 )
        {
            case "iw8_sm_t9burst_mp":
                ref_12c3f( "t9_ch_common_opbundle_04_objective_1", 1 );
                break;
            case "iw8_lm_t9light_mp":
            case "iw8_sm_t9heavy_mp":
            case "iw8_ar_t9slowhandling_mp":
                ref_12c3f( "t9_ch_common_opbundle_05_objective_1", 1 );
                break;
            case "iw8_la_t9launcher_mp":
            case "iw8_sm_t9standard_mp":
                ref_12c3f( "t9_ch_common_opbundle_06_objective_1", 1 );
                break;
            case "iw8_sm_t9handling_mp":
            case "iw8_pi_t9fullauto_mp":
                ref_12c3f( "t9_ch_common_opbundle_07_objective_1", 1 );
                break;
            case "iw8_ar_t9british_mp":
                ref_12c3f( "t9_ch_common_opbundle_04_objective_1", 1 );
                ref_12c3f( "t9_ch_common_opbundle_07_objective_1", 1 );
                break;
        }
    }
    
    if ( var8 >= 14 )
    {
        if ( var7 )
        {
            var95 = 0;
            var96 = 0;
            var97 = 0;
            
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "perk", "hasPerk" ) )
            {
                var37 = scripts\cp_mp\utility\script_utility::getsharedfunc( "perk", "hasPerk" );
                var95 = self [[ var37 ]]( "specialty_quieter" );
                var96 = self [[ var37 ]]( "specialty_no_battle_chatter" );
                var97 = self [[ var37 ]]( "specialty_lightweight" );
            }
            
            var98 = istrue( var95 ) && istrue( var96 ) && istrue( var97 );
            
            if ( turn_on_have_target_hud( "iw8_me_t9scythe_mp" ) && var98 && var5 & 1073741824 )
            {
                if ( !isdefined( self.isgroundwardom ) )
                {
                    self.isgroundwardom = 1;
                }
                else
                {
                    self.isgroundwardom++;
                }
                
                if ( self.isgroundwardom == 2 )
                {
                    ref_12c3f( "t9_ch_global_melee_weapon_kill_while_using_ninja_or_dead_silence_for_weapon_unlock_s7", 1 );
                }
            }
        }
    }
    
    if ( var8 >= 15 )
    {
        if ( var7 )
        {
            if ( turn_on_have_target_hud( "iw8_sm_t9flechette_mp" ) && var11 == "smg" && var5 & 4194304 && !istrue( self.šÿnÚ³²ŽÊGÊÈÚ¥Ø ) )
            {
                ref_12c3f( "t9_ch_global_smg_kill_detected_enemies_for_weapon_unlock_s7", 1 );
                self.šÿnÚ³²ŽÊGÊÈÚ¥Ø = 1;
                return;
            }
            
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x65
function runplunderextractsitetimer( var0 )
{
    var1 = 0;
    
    if ( isdefined( var0 ) )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "getDefaultWeaponBaseName" ) )
        {
            var2 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "getDefaultWeaponBaseName" ) ]]( var0.basename );
            var3 = tablelookup( "mp/statstable.csv", 5, var2, 4 );
            var4 = var3 + "_variant_0";
            var1 = int( tablelookup( "loot/weapon_ids.csv", 6, var4, 0 ) );
        }
    }
    
    return var1;
}

// Params 0
// Size: 0x4f
function resetstreamerposhint()
{
    var0 = 0;
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "player", "lookupCurrentOperator" ) )
    {
        var1 = self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "player", "lookupCurrentOperator" ) ]]( self.team );
        
        if ( var1 != "" )
        {
            var0 = int( tablelookup( "loot/operator_ids.csv", 1, var1, 0 ) );
        }
    }
    
    return var0;
}

// Params 4
// Size: 0x186
function init_silo_elevator( var0, var1, var2, var3 )
{
    if ( !challengesenabledforplayer( var0 ) )
    {
        return;
    }
    
    if ( var3 <= 0 )
    {
        return;
    }
    
    var4 = relic_amped_is_there_valid_new_victim();
    var5 = runplunderextractsitetimer( var0, var2 );
    var6 = resetstreamerposhint( var0 );
    
    if ( !isdefined( var1 ) )
    {
        var1 = [];
    }
    
    var7 = 0;
    
    if ( istrue( var1[ "mounted" ] ) )
    {
        var7 |= 1;
    }
    
    if ( istrue( var0.modifiers[ "collateral" ] ) )
    {
        var7 |= 2;
    }
    
    var8 = 0;
    var9 = weaponclass( var2.basename );
    
    if ( issubstr( var2.basename, "_me_" ) )
    {
        var9 = "melee";
    }
    
    switch ( var9 )
    {
        case "rifle":
            var8 = 3;
            break;
        case "mg":
            var8 = 17;
            break;
        case "melee":
            var8 = 513;
            break;
        case "pistol":
            var8 = 129;
            break;
        case "spread":
            var8 = 9;
            break;
        case "smg":
            var8 = 5;
            break;
        case "sniper":
            var8 = 65;
            break;
        default:
            break;
    }
    
    if ( var9 == "melee" && !isdefined( var0.pers[ "meleeMultikillOnce" ] ) )
    {
        var7 |= 32;
        var0.pers[ "meleeMultikillOnce" ] = 1;
    }
    
    if ( var9 == "lethal" && !isdefined( var0.pers[ "lethalMultikillOnce" ] ) )
    {
        var7 |= 4;
        var0.pers[ "lethalMultikillOnce" ] = 1;
    }
    
    var0 reportchallengeuserevent( "generic", 1, var5, var3, var6, var4, var7, var8 );
}

// Params 10
// Size: 0x492
function init_sentry_traps( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9 )
{
    var10 = resetstuckthermite( var1 );
    var11 = undefined;
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "getGameType" ) )
    {
        var11 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "getGameType" ) ]]();
    }
    
    if ( !isdefined( var11 ) )
    {
        var11 = getdvar( "NKTMKRMSKR" );
    }
    
    var12 = play_station_closed_vo( var6 );
    var13 = play_stealthy_disguise_vo( var1 );
    var14 = [ var7, 0 ];
    var15 = play_sound_from_closest_player( var3 );
    var16 = "";
    
    if ( isdefined( var1.modifiers ) && isdefined( var1.modifiers[ "active_field_upgrade" ] ) )
    {
        var16 = var1.modifiers[ "active_field_upgrade" ];
    }
    
    var17 = 65535;
    
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) )
    {
        var17 = level.br_circle.circleindex;
    }
    
    var18 = undefined;
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "getWeaponRarity" ) )
    {
        var18 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "getWeaponRarity" ) ]]( var6 );
    }
    
    if ( !isdefined( var18 ) )
    {
        var18 = 65535;
    }
    
    if ( var2[ 0 ] == "iav_weapon_mp" || var2[ 0 ] == "tur_apc_rus_mp" )
    {
        var8 = "MOD_CRUSH";
    }
    
    if ( getdvarint( "LTSNLQNRKO", 1 ) )
    {
        var19 = var1 getfireteammembers();
        var20 = var19.size;
    }
    else
    {
        var20 = 1;
    }
    
    if ( isdefined( var2.pers[ "meleeKills" ] ) && var2.pers[ "meleeKills" ] == 5 )
    {
        var2.mp_village2_patches[ "5_melee_weapon_kills" ] = 1;
    }
    
    if ( isdefined( var2.pers[ "smgADSKills" ] ) && var2.pers[ "smgADSKills" ] == 10 )
    {
        var2.mp_village2_patches[ "10_ads_smg_kills" ] = 1;
    }
    
    if ( isdefined( var2.pers[ "arHeadshots" ] ) && var2.pers[ "arHeadshots" ] == 5 )
    {
        var2.mp_village2_patches[ "5_headshot_ar_kills" ] = 1;
    }
    
    if ( isdefined( var2.pers[ "sniperOneShotKills" ] ) && var2.pers[ "sniperOneShotKills" ] == 10 )
    {
        var2.mp_village2_patches[ "10_sn_1shot_kills" ] = 1;
    }
    
    if ( isdefined( var2.pers[ "fireKills" ] ) && var2.pers[ "fireKills" ] == 5 )
    {
        var2.mp_village2_patches[ "5_firekills" ] = 1;
    }
    
    if ( isdefined( var2.pers[ "movingKills" ] ) && var2.pers[ "movingKills" ] == 10 )
    {
        var2.mp_village2_patches[ "10_movingkill" ] = 1;
    }
    
    if ( isdefined( var2.pers[ "pointBlankKills" ] ) && var2.pers[ "pointBlankKills" ] == 10 )
    {
        var2.mp_village2_patches[ "10_closerangekill" ] = 1;
    }
    
    if ( isdefined( var2.pers[ "hipfireKills" ] ) && var2.pers[ "hipfireKills" ] == 10 )
    {
        var2.mp_village2_patches[ "10_hipfirekill" ] = 1;
    }
    
    if ( isdefined( var2.pers[ "slideKills" ] ) && var2.pers[ "slideKills" ] == 3 )
    {
        var2.mp_village2_patches[ "3_slide_kills" ] = 1;
    }
    
    if ( isdefined( var2.pers[ "oneShotOneKills" ] ) && var2.pers[ "oneShotOneKills" ] == 10 )
    {
        var2.mp_village2_patches[ "10_oneshotonekills" ] = 1;
    }
    
    var21 = gettouchinglocaletriggers( var2, var4 );
    var22 = relic_amped_is_there_valid_new_victim();
    var23 = 0;
    var24 = 0;
    var25 = 0;
    var26 = runleadmarkers( var7 );
    var27 = getchallengemapid();
    var2 reportchallengeuserevent( "kill", var15, var3, var5, var6, var11, var22, var13, var14, var16, var17, var21, var9, var20, var18, var20, var10, var23, var26, var25, var24, var27 );
    
    if ( ( var12 == "br" || var12 == "brtdm" ) && ( isplayer( var4 ) || var16 & 32 ) )
    {
        var28 = var3[ 0 ];
        
        if ( isdefined( var2.modifiers ) && istrue( var2.modifiers[ "execution" ] ) )
        {
            if ( isdefined( var2.primaryweaponobj ) )
            {
                if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "getDefaultWeaponBaseName" ) )
                {
                    var28 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "getDefaultWeaponBaseName" ) ]]( var2.primaryweaponobj.basename );
                }
            }
            
            if ( isdefined( var2.weaponlist ) )
            {
                foreach ( var30 in var2.weaponlist )
                {
                    if ( var30.basename == "iw8_me_t9loadout_mp" )
                    {
                        var28 = "iw8_me_t9loadout_mp";
                    }
                }
            }
        }
        
        var2.ref_142ad = var4;
        init_turrets( var2, var16, var28, var7, var13, var5, var6, var1, 1 );
        return;
    }
}

// Params 0
// Size: 0x102
function relic_squadlink_onsteppedclose()
{
    var0 = 0;
    
    if ( isdefined( self.mp_village2_patches ) )
    {
        foreach ( var2 in self.mp_village2_patches )
        {
            switch ( var3 )
            {
                case "5_melee_weapon_kills":
                    var0 |= 2;
                    break;
                case "10_ads_smg_kills":
                    var0 |= 4;
                    break;
                case "5_headshot_ar_kills":
                    var0 |= 8;
                    break;
                case "10_sn_1shot_kills":
                    var0 |= 16;
                    break;
                case "5_firekills":
                    var0 |= 32;
                    break;
                case "10_movingkill":
                    var0 |= 64;
                    break;
                case "10_closerangekill":
                    var0 |= 128;
                    break;
                case "10_hipfirekill":
                    var0 |= 512;
                    break;
                case "3_slide_kills":
                    var0 |= 16384;
                    break;
                case "10_oneshotonekills":
                    var0 |= 32768;
                    break;
            }
        }
    }
    
    if ( function_043e( self ) )
    {
        var0 |= 1;
    }
    
    return var0;
}

// Params 1
// Size: 0x163
function runleadmarkers( var0 )
{
    var1 = [];
    
    for ( var2 = 0; var2 < 10 ; var2++ )
    {
        var1 = "";
    }
    
    if ( !isdefined( var0 ) || !isdefined( var0.attachments ) )
    {
        return var1;
    }
    
    if ( !scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "getDefaultWeaponBaseName" ) )
    {
        return var1;
    }
    
    if ( !scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "attachmentMap_toBase" ) )
    {
        return var1;
    }
    
    if ( !scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "attachmentIsSelectable" ) )
    {
        return var1;
    }
    
    var3 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "getDefaultWeaponBaseName" ) ]]( var0.basename );
    var4 = tablelookup( "mp/statstable.csv", 5, var3, 4 );
    var5 = "loot/" + var4 + "_attachment_ids.csv";
    var6 = scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "attachmentMap_toBase" );
    var7 = scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "attachmentIsSelectable" );
    var2 = 0;
    
    foreach ( var9 in var0.attachments )
    {
        var10 = [[ var6 ]]( var9 );
        
        if ( [[ var7 ]]( var0, var10 ) )
        {
            var1 = tablelookup( var5, 1, var10, 0 );
            var2++;
            continue;
        }
        
        if ( isdefined( level.«rÙšh­lµpUž"oéÊÚ`wÿ ) && isdefined( level.«rÙšh­lµpUž"oéÊÚ`wÿ[ var9 ] ) && [[ var7 ]]( var0, level.«rÙšh­lµpUž"oéÊÚ`wÿ[ var9 ] ) )
        {
            var1 = tablelookup( var5, 1, level.«rÙšh­lµpUž"oéÊÚ`wÿ[ var9 ], 0 );
            var2++;
        }
    }
    
    if ( var2 > 10 )
    {
    }
    
    return var1;
}

// Params 1
// Size: 0x135
function play_station_closed_vo( var0 )
{
    var1 = "";
    var2 = 1;
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "isCACPrimaryOrSecondary" ) )
    {
        if ( ![[ scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "isCACPrimaryOrSecondary" ) ]]( var0 ) )
        {
            var1 = "no_attachments";
        }
    }
    
    if ( isdefined( var0.attachments ) )
    {
        var3 = 0;
        
        foreach ( var5 in var0.attachments )
        {
            var6 = "";
            
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "attachmentMap_toBase" ) )
            {
                var6 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "attachmentMap_toBase" ) ]]( var5 );
            }
            
            if ( var6 == "scope" )
            {
                var3 = 1;
            }
            
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "attachmentIsSelectable" ) )
            {
                if ( [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "attachmentIsSelectable" ) ]]( var0, var6 ) )
                {
                    if ( !var2 )
                    {
                        var1 += "|";
                    }
                    
                    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "remapAttachmentParentName" ) )
                    {
                        var6 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "remapAttachmentParentName" ) ]]( var6 );
                    }
                    
                    var1 += var6;
                    var2 = 0;
                }
            }
        }
        
        if ( var3 )
        {
            if ( !var2 )
            {
                var1 += "|";
            }
            
            var1 += "default_sniper_scope";
        }
    }
    
    return var1;
}

// Params 2
// Size: 0x83
function play_stealthy_disguise_vo( var0, var1 )
{
    var2 = undefined;
    
    if ( isdefined( var0.classstruct ) )
    {
        if ( istrue( var1 ) )
        {
            var2 = var0.classstruct.loadoutextraperks;
        }
        else
        {
            var2 = var0.classstruct.loadoutperks;
        }
    }
    
    var3 = "";
    var4 = 1;
    
    if ( isdefined( var2 ) )
    {
        foreach ( var6 in var2 )
        {
            if ( !var4 )
            {
                var3 += "|";
            }
            
            var3 += var6;
            var4 = 0;
        }
    }
    
    return var3;
}

// Params 1
// Size: 0x19f
function play_sound_from_closest_player( var0 )
{
    var1 = 0;
    
    if ( isplayer( var0 ) )
    {
        var1 |= 1;
    }
    
    var2 = 0;
    var3 = 0;
    var4 = 0;
    var5 = 0;
    
    if ( isdefined( var0.streakinfo ) )
    {
        var1 |= 2;
        var6 = var0.streakinfo.streakname;
        var5 = unsetreduceregendelayonkill( var6 );
        
        switch ( var6 )
        {
            case "sentry_gun":
            case "pac_sentry":
            case "manual_turret":
            case "bradley":
            case "juggernaut":
                var2 = 1;
                break;
            case "nuke":
            case "white_phosphorus":
            case "toma_strike":
            case "precision_airstrike":
            case "hover_jet":
            case "gunship":
            case "cruise_predator":
            case "chopper_support":
            case "chopper_gunner":
                var3 = 1;
                break;
            case "scrambler_drone_guard":
            case "directional_uav":
            case "uav":
            case "radar_drone_overwatch":
                var3 = 1;
                var4 = 1;
                break;
            case "airdrop_multiple":
            case "airdrop":
                var4 = 1;
                break;
        }
        
        if ( var2 )
        {
            var1 |= 8;
        }
        
        if ( var3 )
        {
            var1 |= 4;
        }
        
        if ( var4 )
        {
            var1 |= 16;
        }
    }
    
    if ( isdefined( var0.vehiclename ) || var5 )
    {
        var1 |= 32;
        
        if ( !var2 && isdefined( var0.vehiclename ) && !istrue( var0 scripts\cp_mp\vehicles\vehicle::vehiclecanfly() ) )
        {
            var1 |= 8;
        }
        
        if ( !var3 && isdefined( var0.vehiclename ) && istrue( var0 scripts\cp_mp\vehicles\vehicle::vehiclecanfly() ) )
        {
            var1 |= 4;
        }
    }
    
    if ( isdefined( var0.equipmentref ) )
    {
        var1 |= 64;
    }
    
    if ( isagent( var0 ) )
    {
        var1 = ref_12ce0( var1, var0 );
    }
    
    return var1;
}

// Params 2
// Size: 0xa3
function ref_12ce0( var0, var1 )
{
    if ( isdefined( var1.unittype ) && var1.unittype == "zombie" )
    {
        var0 |= 2048;
    }
    
    if ( !isdefined( var1.aitype ) )
    {
        return var0;
    }
    
    switch ( var1.aitype )
    {
        case "soldier":
            var0 |= 512;
            break;
        case "juggernaut":
            var0 |= 128;
            break;
        case "suicidebomber":
            var0 |= 1024;
            break;
        case "riotshield":
            var0 |= 256;
            break;
        default:
            var0 |= 512;
            break;
    }
    
    return var0;
}

// Params 1
// Size: 0x21
function watchreloading( var0 )
{
    self endon( var0 );
    self waittill( "reload_start" );
    
    if ( level.getallactivequestsforteam >= 11 )
    {
        self.zombieloadout = undefined;
        return;
    }
}

// Params 1
// Size: 0x53, Type: bool
function va_cluster_spawnpoint_valid( var0 )
{
    var1 = weaponclass( var0 );
    
    if ( var1 != "rifle" )
    {
        return false;
    }
    
    var2 = undefined;
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "getWeaponMenuCategory" ) )
    {
        var2 = scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "getWeaponMenuCategory" );
    }
    
    if ( !isdefined( var2 ) )
    {
        return false;
    }
    
    return [[ var2 ]]( var0.basename ) == "weapon_tactical";
}

// Params 1
// Size: 0x1f, Type: bool
function turret_struct( var0 )
{
    var1 = va_cluster_spawnpoint_valid( var0 );
    var2 = weaponclass( var0 );
    return var2 == "rifle" && !var1;
}

// Params 1
// Size: 0x5c, Type: bool
function unset_relic_focus_fire( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return false;
    }
    
    if ( weaponisauto( var0 ) )
    {
        var1 = weaponclass( var0 );
        
        switch ( var1 )
        {
            case "rifle":
                return !va_cluster_spawnpoint_valid( var0 );
            case "smg":
            case "pistol":
            case "spread":
            case "mg":
                return true;
            default:
                return false;
        }
    }
    
    return false;
}

// Params 1
// Size: 0x43
function useserverhud( var0 )
{
    switch ( var0 )
    {
        case "iw8_sn_crossbow_mp":
        case "iw8_me_t9ballisticknife_mp":
        case "iw8_la_t9launcher_mp":
        case "iw8_sn_t9crossbow_mp":
        case "iw8_sm_t9nailgun_mp":
        case "iw8_la_mike32_mp":
            return 1;
        default:
            return 0;
    }
}

// Params 2
// Size: 0x44, Type: bool
function make_c4_pick_up_interact( var0, var1 )
{
    if ( isdefined( var0.origin ) && isdefined( var1.origin ) )
    {
        var2 = var0.origin[ 2 ] - var1.origin[ 2 ];
        var3 = 70;
        
        if ( var2 >= var3 )
        {
            return true;
        }
    }
    
    return false;
}

// Params 0
// Size: 0xbe
function ref_1424b()
{
    var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver( self, 1 );
    
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    if ( !challengesenabledforplayer( var0 ) )
    {
        return;
    }
    
    if ( level.getallactivequestsforteam >= 10 && self.targetname == "motorcycle" )
    {
        if ( !self vehicle_isonground() )
        {
            if ( !isdefined( var0.investigate_someone_using_bomb ) )
            {
                var0.investigate_someone_using_bomb = gettime();
                return;
            }
            
            var1 = gettime() - var0.investigate_someone_using_bomb;
            
            if ( var1 >= 1000 )
            {
                ref_12c3f( var0, "t9_ch_global_dirt_bike_airtime_for_operator_mission_s4", var1 / 1000 );
                var0.investigate_someone_using_bomb = undefined;
                return;
            }
            
            return;
        }
        
        if ( isdefined( var1.investigate_someone_using_bomb ) )
        {
            var1 = gettime() - var1.investigate_someone_using_bomb;
            
            if ( var1 >= 1000 )
            {
                ref_12c3f( var1, "t9_ch_global_dirt_bike_airtime_for_operator_mission_s4", var1 / 1000 );
            }
            
            var1.investigate_someone_using_bomb = undefined;
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x9c, Type: bool
function update_objective_ownerclient( var0 )
{
    if ( isdefined( level.ref_13641 ) && isdefined( level.modeupdateloadoutclass ) )
    {
        var1 = 348100;
        
        foreach ( var3 in level.ref_13641 )
        {
            var4 = distance2dsquared( var0, var3.curorigin );
            
            if ( var4 <= var1 )
            {
                return true;
            }
        }
        
        foreach ( var7 in level.modeupdateloadoutclass )
        {
            var4 = distance2dsquared( var0, var7.origin );
            
            if ( var4 <= var1 )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Params 0
// Size: 0x32
function ref_12083()
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    if ( level.getallactivequestsforteam >= 10 && getdvarint( "scr_enable_br_satellite_hunt", 0 ) == 1 )
    {
        ref_12c3f( "t9_ch_global_secure_satlink_for_s4_event_wz", 1 );
        return;
    }
}

// Params 0
// Size: 0x32
function ref_12005()
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    if ( level.getallactivequestsforteam >= 10 && getdvarint( "scr_enable_br_satellite_hunt", 0 ) == 1 )
    {
        ref_12c3f( "t9_ch_global_collect_satellite_reward_for_s4_event_wz", 1 );
        return;
    }
}

// Params 1
// Size: 0x45
function ref_120a9( var0 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    if ( level.getallactivequestsforteam >= 11 && getdvarint( "scr_br_numbers_tower_enabled", 0 ) == 1 && getdvarint( "scr_br_numbers_tower_usable", 0 ) == 1 )
    {
        ref_12c3f( var0, 1 );
        return;
    }
}

// Params 0
// Size: 0x9, Type: bool
function ref_125f3()
{
    return istrue( self.iszombie );
}

// Params 2
// Size: 0x5
function onplayerteamrevive( var0, var1 )
{
    
}

// Params 1
// Size: 0x4
function onsuccessfulhit( var0 )
{
    
}

// Params 0
// Size: 0x2
function onspawn()
{
    
}

// Params 2
// Size: 0x5
function updatesuperweaponkills( var0, var1 )
{
    
}

// Params 3
// Size: 0x6
function updatesuperkills( var0, var1, var2 )
{
    
}

// Params 1
// Size: 0x4
function resistedstun( var0 )
{
    
}

// Params 0
// Size: 0x2
function triggereddelayedexplosion()
{
    
}

// Params 3
// Size: 0x6
function minedestroyed( var0, var1, var2 )
{
    
}

// Params 0
// Size: 0x2
function roundbegin()
{
    
}

// Params 1
// Size: 0x4
function roundend( var0 )
{
    
}

// Params 6
// Size: 0xc3
function playerdamaged( var0, var1, var2, var3, var4, var5 )
{
    if ( isdefined( var1 ) && !challengesenabledforplayer( var1 ) )
    {
        return;
    }
    
    if ( level.getallactivequestsforteam >= 12 )
    {
        if ( isdefined( var1 ) )
        {
            ref_12c3f( var1, "t9_ch_global_damage_done_for_operator_mission_s6", var2 );
            ref_12c3f( var1, "t9_ch_global_damage_done_s6", var2 );
        }
    }
    
    if ( turn_on_have_target_hud( "iw8_ar_t9soviet_mp" ) && isdefined( var1 ) && !isdefined( var1.ref_139e3 ) )
    {
        if ( isdefined( var4 ) && turret_struct( var4 ) )
        {
            if ( !isdefined( var1.ref_11b21 ) )
            {
                var1.ref_11b21 = var2;
            }
            else
            {
                var1.ref_11b21 += var2;
            }
            
            if ( var1.ref_11b21 >= 1000 )
            {
                ref_12c3f( var1, "t9_ch_global_ar_deal_1000_damage_for_weapon_unlock_s7", 1 );
                var1.ref_139e3 = 1;
                return;
            }
            
            return;
        }
        
        return;
    }
}

// Params 2
// Size: 0x5
function processuavassist( var0, var1 )
{
    
}

// Params 5
// Size: 0x8
function killstreakdamaged( var0, var1, var2, var3, var4 )
{
    
}

// Params 1
// Size: 0x2e, Type: bool
function unsetreduceregendelayonkill( var0 )
{
    switch ( var0 )
    {
        case "sentry_gun":
        case "manual_turret":
        case "cruise_predator":
        case "juggernaut":
            return false;
    }
    
    return true;
}

// Params 1
// Size: 0x22
function getkillstreaknamefromweapon( var0 )
{
    var1 = var0.basename;
    
    if ( isdefined( level.killstreakweaponmap[ var1 ] ) )
    {
        return level.killstreakweaponmap[ var1 ];
    }
    
    return undefined;
}

// Params 2
// Size: 0x5
function processfinalkillchallenges( var0, var1 )
{
    
}

// Params 1
// Size: 0x119
function usedkillstreak( var0 )
{
    if ( !isdefined( self.vote_player_init ) )
    {
        if ( !isdefined( self.fuelsequencestability ) )
        {
            self.fuelsequencestability = 1;
        }
        else
        {
            self.fuelsequencestability++;
        }
        
        if ( self.fuelsequencestability >= 5 )
        {
            ref_12c3f( "t9_ch_global_x_scorestreak_activations_single_match_s3", 1 );
            self.vote_player_init = 1;
        }
    }
    
    if ( level.getallactivequestsforteam >= 9 && ( var0 == "nuke" || var0 == "precision_airstrike" || var0 == "cruise_predator" || var0 == "manual_turret" || var0 == "pac_sentry" || var0 == "toma_strike" || var0 == "chopper_gunner" || var0 == "bradley" || var0 == "gunship" || var0 == "fuel_airstrike" || var0 == "chopper_support" || var0 == "sentry_gun" || var0 == "white_phosphorus" || var0 == "hover_jet" || var0 == "juggernaut" || var0 == "assault_drone" ) )
    {
        ref_12c3f( "t9_ch_global_call_in_lethal_scorestreak_for_operator_mission_s3", 1 );
    }
    
    if ( level.getallactivequestsforteam >= 12 )
    {
        ref_12c3f( "t9_ch_common_opbundle_07_objective_3", 1 );
        return;
    }
}

// Params 0
// Size: 0x8f
function resetstuckthermite()
{
    var0 = [];
    
    if ( isdefined( self.team ) && scripts\cp_mp\utility\script_utility::issharedfuncdefined( "player", "lookupCurrentOperator" ) )
    {
        GscBinSkip0( 0x2e, 0, self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "player", "lookupCurrentOperator" ) ]]( self.team ) );
        // Unknown operator ( 0x2e, iw8, PC )
    }
    
    GscBinSkip0( 0x2e, 0, "" );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 1
// Size: 0x12
function attachmentgroup( var0 )
{
    return tablelookup( "mp/attachmenttable.csv", 4, var0, 2 );
}

// Params 1
// Size: 0x25
function getoperatorfavoriteweapon( var0 )
{
    var1 = "";
    
    if ( var0 != "" )
    {
        var1 = tablelookup( "operators.csv", 1, var0, 33 );
    }
    
    return var1;
}

