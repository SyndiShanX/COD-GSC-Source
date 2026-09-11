
// Params 0
// Size: 0x9
function fulton_actors_players()
{
    thread fulton_used();
}

// Params 2
// Size: 0x98
function fulton_ac130_model( var0, var1 )
{
    var2 = self;
    calloutmarkerping_removecallout( var2, var0 );
    var3 = getdvarint( "scr_calloutmarkerping_zoffset_entity_enemy", 82 );
    var4 = var1.origin + ( 0, 0, var3 );
    var5 = 1;
    var6 = var2 sethasspecialistbonus( 1 );
    var7 = getdvarint( "MRPQRTKTLQ", 3 );
    var8 = var2 sethasspecialistbonus( 2 );
    
    if ( var8 < var6 && var7 > 1 )
    {
        var6 = var8;
        var5 = 2;
    }
    
    var9 = var2 sethasspecialistbonus( 3 );
    
    if ( var9 < var6 && var7 > 2 )
    {
        var6 = var9;
        var5 = 3;
    }
    
    var2 calloutmarkerping_create( var5, var4, 0 );
    thread addquestrewardtierframeend( var2 );
    addquestrewardtier( "Enemy switched to danger" );
}

// Params 1
// Size: 0x4
function addquestrewardtier( var0 )
{
    
}

// Params 1
// Size: 0x17, Type: bool
function addpostlaunchspawns( var0 )
{
    return var0 == 9 || var0 == 10 || var0 == 11;
}

// Params 1
// Size: 0x17, Type: bool
function addplundercarrycredit( var0 )
{
    return var0 == 4 || var0 == 5 || var0 == 6;
}

// Params 1
// Size: 0x17, Type: bool
function addplayeraslootleader( var0 )
{
    return var0 == 1 || var0 == 2 || var0 == 3;
}

// Params 3
// Size: 0x202
function addquestrewardtierframeend( var0, var1, var2 )
{
    var3 = self;
    level endon( "game_ended" );
    var3 endon( "disconnect" );
    var4 = 2;
    var5 = undefined;
    
    if ( addplundercarrycredit( var0 ) )
    {
        var6 = var3 calloutmarkerping_getsavedzoffset( var0 );
        
        if ( isdefined( var6 ) )
        {
            var7 = getdvarint( "scr_calloutmarkerping_track_player_switch_to_danger", 1 );
            
            if ( var7 && additionalrecondronetargets( var6, var3 ) )
            {
                if ( isdefined( level.ref_11a32 ) && getdvar( "scr_br_gametype", "" ) == "kingslayer" && scripts\engine\utility::array_contains( level.ref_11a32, var6 ) )
                {
                    var4 = getdvarfloat( "scr_calloutmarkerping_track_king_time", 0 );
                }
                else
                {
                    var4 = getdvarfloat( "scr_calloutmarkerping_track_player_time", 3 );
                }
                
                var5 = var6;
                addquestrewardtier( "Enemy tracked!" );
                
                if ( !istrue( var2 ) )
                {
                    var6.update_bomb_vest_lua = 1;
                }
            }
            
            thread fulton_interactions_disabled( var3, var0 );
            
            if ( isdefined( var5 ) && istrue( var2 ) )
            {
                return;
            }
        }
    }
    
    var3 notify( "predictiveCalloutClear_" + var0 );
    var3 endon( "predictiveCalloutClear_" + var0 );
    
    if ( addpostlaunchspawns( var0 ) )
    {
        var8 = var3 calloutmarkerping_getsavedzoffset( var0 );
        thread calloutmarkerping_watchscriptabledeath( var3, var0 );
    }
    else if ( var0 == 0 )
    {
        if ( getdvarint( "scr_calloutmarkerping_navigation_proximity_cancel", 0 ) )
        {
            thread fulton_create();
        }
    }
    else if ( var0 == 8 )
    {
        var8 = var3 calloutmarkerping_getsavedzoffset( var0 );
        thread fulton_interactions_disabled( var3, var0 );
        thread fulton_handledamage( var3, var0 );
    }
    else if ( var0 == 7 )
    {
        var9 = self getnodeoffset_code( 7 );
        
        if ( var9 == -1 )
        {
            calloutmarkerping_removecallout( var0 );
        }
        else
        {
            thread fulton_refundsuper( var3, var0 );
            thread fulton_planted( var3, var0 );
        }
    }
    else if ( var0 == 12 )
    {
        thread fulton_open( var3, 12 );
    }
    
    if ( !isdefined( var5 ) )
    {
        var4 = fulton_actors( var3, var0 );
    }
    
    addquestrewardtier( "Timeout value before wait: " + var4 + " | poolID: " + var0 );
    wait var4;
    
    if ( isdefined( var5 ) && isdefined( var3 ) )
    {
        if ( isdefined( var5.update_bomb_vest_lua ) )
        {
            var5.update_bomb_vest_lua = undefined;
        }
        
        thread fulton_ac130_model( var3, var0 );
        return;
    }
    
    addquestrewardtier( "Pool timed out: " + var0 );
    calloutmarkerping_removecallout( var3, var0 );
}

// Params 0
// Size: 0x22
function addpowerbutton()
{
    var0 = self;
    
    for ( var1 = 0; var1 < 13 ; var1++ )
    {
        if ( var0 calloutmarkerping_getfeedback( var1 ) )
        {
            return var1;
        }
    }
    
    return -1;
}

// Params 0
// Size: 0xf1
function addproptolist()
{
    var0 = self;
    level endon( "game_ended" );
    var0 endon( "disconnect" );
    
    for ( ;; )
    {
        var0 waittill( "luinotifyserver", var1, var2, var3 );
        
        if ( !isdefined( var1 ) || !isdefined( var2 ) )
        {
            continue;
        }
        
        addquestrewardtier( "Notification " + var1 + " on pool " + var2 );
        
        switch ( var1 )
        {
            case "calloutmarkerping_added":
                addallkillstreaksunlocked( var0, var2 );
                break;
            case "calloutmarkerping_cleared":
                addbattlepassxpmultiplier( var0, var2 );
                break;
            case "calloutmarkerping_acknowledged":
                addaccesscard( var0, var2, var3 );
                break;
            case "calloutmarkerping_acknowledged_cancel":
                addaliasarraytoqueue( var0, var2 );
                break;
            case "calloutmarkerping_enemy_repinged":
                adddroponplayerdeath( var0, var2 );
                break;
            case "map_ping_delete_marker":
                addedcollision( var0 );
                break;
            case "br_inventory_slot_request":
                addallkillstreaksunlockedinonelife( var0, var2 );
                break;
            default:
                break;
        }
    }
}

// Params 0
// Size: 0x34
function calloutmarkerping_initplayer()
{
    var0 = self;
    
    if ( !isdefined( var0.fxrings ) )
    {
        var0.fxrings = [];
    }
    
    if ( !isdefined( var0.fulton_repositoryatcapacitycallback ) )
    {
        var0.fulton_repositoryatcapacitycallback = [];
    }
    
    thread addproptolist();
}

// Params 1
// Size: 0x4c, Type: bool
function addscriptedspawnpoints( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return false;
    }
    
    var1 = var0 getscriptablepartnameatindex( 0 );
    
    if ( !isdefined( var1 ) )
    {
        return false;
    }
    
    var2 = var0 getscriptablepartstate( var1, 1 );
    
    if ( !isdefined( var2 ) )
    {
        return false;
    }
    
    var3 = var0 getscriptablepartstatefield( var1, var2, "type" );
    
    if ( !isdefined( var3 ) )
    {
        return false;
    }
    
    if ( var3 != "useable" )
    {
        return false;
    }
    
    return true;
}

// Params 2
// Size: 0x4d, Type: bool
function additionalrecondronetargets( var0, var1 )
{
    if ( !isdefined( var0 ) )
    {
        return false;
    }
    
    if ( !isplayer( var0 ) && !isagent( var0 ) )
    {
        return false;
    }
    
    if ( !isdefined( var0.team ) )
    {
        return false;
    }
    
    if ( var0.team == "neutral" )
    {
        return false;
    }
    
    return var0.team != var1.team;
}

// Params 1
// Size: 0x50, Type: bool
function addjuggsettings( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return false;
    }
    
    if ( !isent( var0 ) )
    {
        return ( issubstr( var0.type, "brloot_plunder_extraction" ) || issubstr( var0.type, "equip_fulton_mp" ) );
    }
    
    if ( !isdefined( var0.model ) )
    {
        return false;
    }
    
    return var0.model == "military_skyhook_far_ch3";
}

// Params 1
// Size: 0x4b, Type: bool
function addlaststandoverheadiconcallback( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return false;
    }
    
    if ( !isent( var0 ) )
    {
        return false;
    }
    
    if ( !isdefined( var0.model ) )
    {
        return false;
    }
    
    return var0.model == "br_skyhook_extraction_base_01_ch3" || var0.model == "lm_military_skyhook_extraction_01_ch3" || istrue( var0.‘náo•7 qò‹[€ );
}

// Params 1
// Size: 0x97
function addincoming( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return 0;
    }
    
    if ( !isent( var0 ) )
    {
        return 0;
    }
    
    if ( !isdefined( var0.cratetype ) )
    {
        return 0;
    }
    
    switch ( var0.cratetype )
    {
        case "medical_crate":
        case "bonus_points_crate":
        case "heavy_weapon_crate":
        case "extra_life_crate":
        case "battle_royale_decon":
        case "battle_royale_tactical_device":
        case "battle_royale_chopper_loot":
        case "battle_royale_loadout":
        case "battle_royale_c130_loot":
        case "battle_royale_juggernaut":
        case "manual_turret":
        case "killstreak":
        case "juggernaut":
            return 1;
        default:
            return 0;
    }
}

// Params 1
// Size: 0x26, Type: bool
function addexecutionquip( var0 )
{
    if ( !isdefined( var0 ) || !isdefined( var0.vehiclename ) )
    {
        return false;
    }
    
    return var0.vehiclename == "cargo_truck_mg";
}

// Params 1
// Size: 0x1d, Type: bool
function fulton_crate_model_playclosedidle( var0 )
{
    return isdefined( var0.equipmentref ) && var0.equipmentref == "equip_supportBox";
}

// Params 1
// Size: 0x29, Type: bool
function addjuggernautcharge( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return false;
    }
    
    if ( !var0 getscriptableisloot() )
    {
        return false;
    }
    
    if ( var0.type != "br_plunder_box" )
    {
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0x68, Type: bool
function fulton_cancreate( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return false;
    }
    
    if ( !isent( var0 ) )
    {
        return false;
    }
    
    if ( !isdefined( var0.classname ) )
    {
        return false;
    }
    
    return issubstr( var0.classname, "grenade" ) || issubstr( var0.classname, "c4_" ) || issubstr( var0.classname, "proximity_explosive_" ) || issubstr( var0.classname, "claymore_" );
}

// Params 2
// Size: 0x4d, Type: bool
function fullweaponname( var0, var1 )
{
    if ( var0 ismlgspectator() || var0 isspectatingplayer() )
    {
        return false;
    }
    
    if ( !isalive( var0 ) )
    {
        return false;
    }
    
    if ( istrue( var0.mapmarkermodeenabled ) && !isdefined( var1 ) )
    {
        return false;
    }
    
    if ( istrue( var0.gulag ) )
    {
        return false;
    }
    
    if ( var0 scripts\cp_mp\utility\player_utility::isusingremote() )
    {
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0x9a
function remove_punchcard( var0 )
{
    switch ( var0 )
    {
        case 0:
            return undefined;
        case 1:
            return undefined;
        case 2:
            return undefined;
        case 3:
            return undefined;
        case 10:
            return "ping_need_gun";
        case 4:
            return "ping_need_armor";
        case 5:
            return "ping_need_midcal";
        case 6:
            return "ping_need_shells";
        case 7:
            return "ping_need_smallcal";
        case 8:
            return "ping_need_launcher";
        case 9:
            return "ping_need_highcal";
        default:
            break;
    }
    
    return undefined;
}

// Params 1
// Size: 0xae
function remove_prohibited_weapons( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return "";
    }
    
    switch ( var0 )
    {
        case 0:
            return "plunder";
        case 10:
            return "weapon";
        case 4:
            return "brloot_armor_plate";
        case 3:
            return "brloot_equip_gasmask";
        case 5:
            return "brloot_ammo_762";
        case 6:
            return "brloot_ammo_12g";
        case 7:
            return "brloot_ammo_919";
        case 8:
            return "brloot_ammo_rocket";
        case 9:
            return "brloot_ammo_50cal";
        case 2:
        case 1:
            return "unsupported";
        default:
            return "";
    }
}

// Params 1
// Size: 0x72
function fulton_handlefataldamage( var0 )
{
    var1 = self;
    
    if ( !fullweaponname( var1 ) )
    {
        return;
    }
    
    var2 = var1 calloutmarkerping_getfeedback( 12 );
    
    if ( var2 )
    {
        var3 = var1 isdismembermentenabledforplayer( 12 );
        calloutmarkerping_removecallout( var1, 12 );
        
        if ( var3 == var0 )
        {
            fulton_deletenextframe( var1, "br_ping_cancel", 12 );
            return;
        }
    }
    
    var4 = getdvarint( "scr_calloutmarkerping_zoffset_danger", 82 );
    var5 = ( 0, 0, var4 );
    var1 calloutmarkerping_create( 12, var5, var0 );
    thread addquestrewardtierframeend( var1, 12 );
    thread fxred( var1 );
}

// Params 1
// Size: 0x33
function fxred( var0 )
{
    var1 = self;
    wait getdvarfloat( "scr_calloutmarkerping_delay_between_vo_and_sfx_secs_inventory", 0.5 );
    var2 = remove_punchcard( var0 );
    
    if ( isdefined( var2 ) && isdefined( var1 ) )
    {
        fxent2( var1, var2, 12 );
        return;
    }
}

// Params 1
// Size: 0x32
function add_track_points( var0 )
{
    var1 = self;
    
    if ( isalive( var1 ) )
    {
        return;
    }
    
    if ( !addpostlaunchspawns( var0 ) )
    {
        return;
    }
    
    var2 = var1 calloutmarkerping_getsavedzoffset( var0 );
    
    if ( !addjuggernautcharge( var2 ) )
    {
        return;
    }
    
    var1 notify( "buybackRequested" );
}

// Params 0
// Size: 0x2
function fulton_hostage_vo()
{
    
}

// Params 1
// Size: 0x260
function fulton_repositoryusecallback( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    var1 = self;
    var2 = var1 calloutmarkerping_getsavedzoffset( var0 );
    var3 = undefined;
    
    if ( addpostlaunchspawns( var0 ) )
    {
        var4 = undefined;
        var5 = 0;
        var6 = 0;
        var7 = 0;
        var8 = 0;
        
        if ( isdefined( var2 ) )
        {
            var4 = var2;
        }
        else
        {
            return;
        }
        
        if ( isdefined( var4 ) )
        {
            var5 = var4 scriptableisdoor();
            
            if ( var5 )
            {
                var6 = var4 scriptabledoorisclosed();
            }
            else
            {
                var7 = var4 isplayerheadless();
            }
            
            var8 = addscriptedspawnpoints( var4 );
        }
        
        if ( var7 && !var8 || var5 && !var6 )
        {
            var3 = "ping_location_looted";
        }
        else if ( var5 )
        {
            return;
        }
        else if ( isdefined( var4 ) && isdefined( var4.entity ) )
        {
            if ( addincoming( var4.entity ) )
            {
                var3 = "ping_killstreaks_carepkg";
            }
            else if ( istrue( var4.entity.›;+B›GÛäçpsì ) || istrue( var4.entity.¾<ãC¶H—¯ª¸!#W]@¡gOó ) )
            {
                var3 = "ping_plunder_vendor";
            }
            else if ( istrue( var4.entity.isjuggernaut ) )
            {
                var3 = "ping_killstreaks_juggernaut";
            }
            else if ( addjuggsettings( var2 ) )
            {
                var3 = "ping_plunder_bank";
            }
            else if ( addexecutionquip( var4.entity ) )
            {
                var3 = "ping_vehicle_heavy";
            }
            else if ( istrue( var4.entity.use_vehicle_turret ) )
            {
                var3 = "ping_pickup_generic";
            }
            else if ( istrue( var4.entity.unset_relic_noregen ) )
            {
                var3 = "ping_location_generic";
            }
            else if ( addlaststandoverheadiconcallback( var4.entity ) )
            {
                var3 = "ping_location_generic";
            }
        }
        else
        {
            var3 = fusesound( var1, var0, var2 );
        }
    }
    else if ( addplundercarrycredit( var0 ) )
    {
        var3 = fuselit( var1, var0, var2 );
    }
    else if ( addplayeraslootleader( var0 ) )
    {
        var3 = "ping_enemy_general";
    }
    else
    {
        switch ( var0 )
        {
            case 0:
                if ( level.gametype == "br" && isdefined( var1.br_infil_type ) )
                {
                    if ( istrue( var1.tutorial_usingparachute ) )
                    {
                        var3 = "ping_location_landing";
                    }
                    else
                    {
                        var3 = "ping_location_landing_suggestion";
                    }
                }
                else
                {
                    var3 = "ping_location_generic";
                }
                
                break;
            case 8:
                var3 = fx_ent_index( var1, var0, var2 );
                break;
            case 7:
                var3 = fx_ents( var1, var0 );
                break;
            default:
                break;
        }
    }
    
    fxent2( var1, var3, var0 );
}

// Params 1
// Size: 0x102
function addplayerasexpiredlootleader( var0 )
{
    if ( !scripts\cp_mp\utility\script_utility::issharedfuncdefined( "challenges", "onPing" ) )
    {
        return;
    }
    
    if ( addpostlaunchspawns( var0 ) )
    {
        self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "challenges", "onPing" ) ]]( "object" );
        return;
    }
    
    if ( addplundercarrycredit( var0 ) )
    {
        var1 = self calloutmarkerping_getsavedzoffset( var0 );
        
        if ( isdefined( var1 ) )
        {
            if ( additionalrecondronetargets( var1, self ) )
            {
                self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "challenges", "onPing" ) ]]( "enemy" );
                return;
            }
            
            if ( !isplayer( var1 ) )
            {
                self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "challenges", "onPing" ) ]]( "object" );
                return;
            }
            
            return;
        }
        
        return;
    }
    
    if ( addplayeraslootleader( var0 ) )
    {
        self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "challenges", "onPing" ) ]]( "danger" );
        return;
    }
    
    switch ( var0 )
    {
        case 12:
        case 8:
            self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "challenges", "onPing" ) ]]( "object" );
            break;
        case 7:
        case 0:
            break;
    }
}

// Params 2
// Size: 0x20f
function fuselit( var0, var1 )
{
    var2 = self;
    
    if ( isdefined( var1 ) && isent( var1 ) )
    {
        var3 = var1;
    }
    else
    {
        return "";
    }
    
    if ( isplayer( var3 ) && var3.team == self.team )
    {
        return "ping_response_helpme";
    }
    else if ( isdefined( var3.juggcontext ) || istrue( var3.isjuggernaut ) )
    {
        return "ping_killstreaks_juggernaut";
    }
    else if ( fulton_crate_model_playclosedidle( var3 ) )
    {
        return "ping_pickup_generic";
    }
    else if ( isdefined( var3.equipmentref ) && var3.equipmentref == "equip_armorBox" )
    {
        return "ping_pickup_armor";
    }
    else if ( fulton_cancreate( var3 ) )
    {
        return "ping_enemy_traps";
    }
    else if ( addjuggsettings( var3 ) )
    {
        return "ping_plunder_bank";
    }
    else if ( isplayer( var3 ) && istrue( var3.inlaststand ) && var3.team != self.team )
    {
        var4 = fx_model( var2, "flavor_player_execution" );
        var5 = fx_obj( var2, "flavor_player_execution" );
        
        if ( isdefined( var4 ) && isdefined( var5 ) )
        {
            var6 = soundexists( var4 );
            var7 = soundexists( var5 );
            
            if ( istrue( var6 ) && istrue( var7 ) )
            {
                return "flavor_player_execution";
            }
        }
    }
    else if ( var3.model == "military_ammo_restock_location" )
    {
        return "ping_pickup_generic";
    }
    else if ( var3.model == "ammo_restock_location_ch3" )
    {
        return "ping_pickup_generic";
    }
    else if ( issubstr( var3.model, "offhand_wm_container_gas_tank" ) || var3.model == "offhand_wm_jerrycan_thrown" )
    {
        return "ping_ammo_grenadelethal";
    }
    else if ( scripts\mp\utility\entity::isturret( var3 ) )
    {
        if ( isdefined( var3.owner ) && var3.owner.team != self.team )
        {
            return "ping_killstreaks_shieldturret_enemy";
        }
        
        return "ping_killstreaks_shieldturret_open";
    }
    else if ( issubstr( var3.model, "train_" ) )
    {
        return "ping_location_generic";
    }
    else if ( issubstr( var3.model, "cuniform" ) )
    {
        return "ping_killstreaks_scrambler";
    }
    
    return "ping_enemy_infantry";
}

// Params 2
// Size: 0x390
function fx_ent_index( var0, var1 )
{
    var2 = self;
    
    if ( isdefined( var1 ) && isent( var1 ) )
    {
        var3 = var1;
    }
    else
    {
        return "";
    }
    
    if ( isdefined( var3.streakname ) )
    {
        switch ( var3.streakname )
        {
            case "gunship":
                return "ping_killstreaks_gunship";
            case "chopper_gunner":
                return "ping_killstreaks_helo";
            case "radar_drone_recon":
                return "ping_killstreaks_recon";
            case "pac_sentry":
                return "ping_killstreaks_recon";
            case "assault_drone":
                return "equipment_incoming_generic";
            default:
                break;
        }
    }
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "ping", "ping_cp_getCPVehicleCallout" ) )
    {
        var4 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "ping", "ping_cp_getCPVehicleCallout" ) ]]( var3 );
        
        if ( isdefined( var4 ) && istrue( var4.fail_on_transmission_timeout ) )
        {
            return var4.ref_142f4;
        }
    }
    
    if ( !isdefined( var3.vehiclename ) )
    {
        return "ping_vehicle_concat_no_driver";
    }
    
    var5 = addplatepouch( var3, var2.team );
    var6 = isdefined( var3.ownerteam ) && var3.ownerteam == var2.team;
    
    if ( istrue( var5 ) )
    {
        switch ( var3.vehiclename )
        {
            case "veh_indigo":
            case "open_jeep":
            case "cargo_truck_susp":
            case "veh_a10fd":
            case "motorcycle":
            case "open_jeep_carpoc":
            case "van":
            case "technical":
            case "tac_rover":
            case "pickup_truck":
            case "jeep":
            case "cargo_truck":
            case "atv":
                return "ping_enemy_vehicle_light";
            case "cargo_truck_susp_aa":
            case "veh_bt":
            case "cargo_truck_mg":
            case "apc_russian":
                return "ping_enemy_vehicle_heavy";
            case "little_bird_mg":
            case "little_bird":
                return "ping_killstreaks_helo";
            case "light_tank":
                return "ping_killstreaks_cobalt";
            case "hover_jet":
                return "ping_killstreaks_ravager";
            case "pac_sentry":
                return "ping_killstreaks_wheelson";
            case "magma_plunder_chopper":
                return "ping_vehicle_helo";
            default:
                break;
        }
        
        return;
    }
    
    if ( istrue( var6 ) )
    {
        switch ( var3.vehiclename )
        {
            case "veh_indigo":
            case "open_jeep":
            case "cargo_truck_susp":
            case "veh_bt":
            case "veh_a10fd":
            case "motorcycle":
            case "open_jeep_carpoc":
            case "van":
            case "technical":
            case "tac_rover":
            case "pickup_truck":
            case "large_transport":
            case "jeep":
            case "cargo_truck":
            case "atv":
                return "ping_vehicle_light";
            case "cargo_truck_susp_aa":
            case "light_tank":
            case "cargo_truck_mg":
            case "apc_russian":
                return "ping_vehicle_heavy";
            case "magma_plunder_chopper":
            case "little_bird_mg":
            case "little_bird":
                return "ping_vehicle_helo";
            default:
                break;
        }
        
        return;
    }
    
    switch ( var3.vehiclename )
    {
        case "veh_indigo":
        case "open_jeep":
        case "cargo_truck_susp":
        case "veh_a10fd":
        case "motorcycle":
        case "open_jeep_carpoc":
        case "van":
        case "technical":
        case "tac_rover":
        case "pickup_truck":
        case "large_transport":
        case "jeep":
        case "cargo_truck":
        case "atv":
            return "ping_vehicle_light";
        case "convoy_truck":
        case "cargo_truck_susp_aa":
        case "veh_bt":
        case "light_tank":
        case "cargo_truck_mg":
        case "apc_russian":
            return "ping_vehicle_heavy";
        case "magma_plunder_chopper":
        case "loot_chopper":
        case "little_bird_mg":
        case "little_bird":
            return "ping_vehicle_helo";
        case "escort_truck":
            return "ping_vehicle_light";
        default:
            break;
    }
}

// Params 1
// Size: 0x1d0
function fx_ents( var0 )
{
    var1 = self;
    
    if ( level.gametype != "br" )
    {
        return "ping_location_generic";
    }
    
    var2 = var1 getnodeoffset_code( 7 );
    
    if ( isdefined( level.questinfo ) && isdefined( level.questinfo.quests ) && isdefined( level.questinfo.quests[ "vip" ] ) && isdefined( level.questinfo.quests[ "vip" ].instances ) )
    {
        foreach ( var4 in level.questinfo.quests[ "vip" ].instances )
        {
            var5 = var4.objectiveiconid;
            
            if ( !isdefined( var5 ) )
            {
                continue;
            }
            
            if ( var5 == var2 )
            {
                return "ping_enemy_infantry";
            }
        }
    }
    
    var7 = var1 calloutmarkerping_entityzoffset( "ui_br_objective_index" );
    
    if ( !isdefined( var7 ) || var7 == 0 )
    {
        return "ping_location_generic";
    }
    
    var8 = tablelookup( "mp/brmissions.csv", 0, var7, 1 );
    
    switch ( var8 )
    {
        case "sabotage":
        case "x2_amb_signal":
        case "x2_stash":
        case "x2_map":
        case "x2_signal":
        case "x2_amb1":
        case "x2_bomb":
        case "x1fin":
        case "history":
        case "x1stash":
        case "assassination":
        case "smokinggun":
        case "blueprintextract":
            if ( func_load_difficulty_table( var1, "ping_objective_contract" ) )
            {
                return "ping_objective_contract";
            }
            
            return "ping_location_generic";
        case "lep":
        case "scavenger_adler":
        case "scavenger":
            if ( func_load_difficulty_table( var1, "ping_objective_contract" ) )
            {
                return "ping_objective_contract";
            }
            
            return "ping_objective_device";
        case "timedrun":
            if ( func_load_difficulty_table( var1, "ping_objective_contract" ) )
            {
                return "ping_objective_contract";
            }
            
            return "ping_plunder_vendor";
        default:
            break;
    }
    
    return "ping_location_generic";
}

// Params 2
// Size: 0xa00
function fusesound( var0, var1 )
{
    var2 = self;
    
    if ( isdefined( var1 ) && isdefined( var1.type ) )
    {
        var3 = var1.type;
    }
    else
    {
        return "";
    }
    
    var4 = 0;
    var5 = tablelookupgetnumrows( level.brloottablename );
    var6 = undefined;
    
    for ( var7 = var4; var7 < var5 ; var7++ )
    {
        var8 = tablelookupbyrow( level.brloottablename, var7, 1 );
        
        if ( var8 == var3 )
        {
            var6 = tablelookupbyrow( level.brloottablename, var7, 12 );
            
            if ( var6 == "" )
            {
            }
            
            break;
        }
    }
    
    if ( !isdefined( var6 ) )
    {
        if ( var3 == "brloot_plunder_extraction_site_01" || var3 == "brloot_plunder_extraction_site_02" || var3 == "equip_fulton_mp" )
        {
            if ( func_load_difficulty_table( var2, "ping_vehicle_cash_deposit_helo" ) )
            {
                return "ping_vehicle_cash_deposit_helo";
            }
            
            return "ping_plunder_bank";
        }
        else if ( var3 == "ks_airdrop_crate_br" )
        {
            return "ping_plunder_cache";
        }
        else if ( var3 == "br_carriable_propane" || var3 == "br_carriable_neurotoxin" || var3 == "br_carriable_gasoline" )
        {
            return "ping_ammo_grenadelethal";
        }
        else if ( var3 == "scriptable_skyhook_placed" || var3 == "broken_atm_scriptable" || var3 == "br_loot_cursed_chest" || var3 == "br_doomstation" )
        {
            return "ping_location_generic";
        }
        else if ( isdefined( var1 ) && isdefined( var1.classname ) && var1.classname == "scriptable_br_military_ammo_restock_noent" )
        {
            return "ping_pickup_generic";
        }
        
        return "";
    }
    
    var9 = "";
    
    if ( issubstr( var6, "_PLUNDER_CASH" ) )
    {
        var9 = "ping_plunder_loot";
    }
    else if ( issubstr( var6, "MENDOTA/INTEL" ) || issubstr( var6, "MENDOTA/KILLSTREAK" ) )
    {
        var9 = "ping_pickup_generic";
    }
    else if ( issubstr( var6, "ARMORY_KIOSK" ) )
    {
        if ( !isalive( var2 ) )
        {
            var9 = "ping_aidstation";
        }
        else
        {
            var9 = "ping_plunder_vendor";
        }
    }
    else if ( issubstr( var6, "WINE_BOTTLE" ) || issubstr( var6, "SHOVEL" ) )
    {
        var9 = "ping_pickup_generic";
    }
    else if ( issubstr( var6, "HATCH_SHORT" ) )
    {
        var9 = "ping_location_generic";
    }
    else if ( issubstr( var6, "PORTABLE_KIOSK" ) )
    {
        var9 = "ping_plunder_vendor";
    }
    else if ( issubstr( var6, "ARMORY_TRADER" ) )
    {
        var9 = "ping_location_generic";
    }
    else if ( issubstr( var6, "_SHOTGUN" ) )
    {
        var9 = "ping_ammo_shotgun";
    }
    else if ( issubstr( var6, "_AMMO_LAUNCHER" ) )
    {
        var9 = "ping_ammo_launcher";
    }
    else if ( issubstr( var6, "_SNIPER" ) )
    {
        var9 = "ping_ammo_highcal";
    }
    else if ( issubstr( var6, "_AR_LMG" ) )
    {
        var9 = "ping_ammo_midcaliber";
    }
    else if ( issubstr( var6, "_PISTOL_SMG" ) )
    {
        var9 = "ping_ammo_smallcal";
    }
    else if ( issubstr( var6, "ARMOR" ) || var6 == "EQUIPMENT/BR_PLATE_POUCH" )
    {
        var9 = "ping_pickup_armor";
    }
    else if ( issubstr( var6, "_AR" ) )
    {
        var9 = "ping_weapon_assaultrifle";
    }
    else if ( issubstr( var6, "_SM" ) )
    {
        var9 = "ping_weapon_smg";
    }
    else if ( issubstr( var6, "_SH" ) )
    {
        var9 = "ping_weapon_shotgun";
    }
    else if ( issubstr( var6, "_PI" ) )
    {
        var9 = "ping_weapon_pistol";
    }
    else if ( issubstr( var6, "_SN" ) )
    {
        var9 = "ping_weapon_sniper";
    }
    else if ( issubstr( var6, "_LM" ) )
    {
        var9 = "ping_weapon_lmg";
    }
    else if ( issubstr( var6, "_LA" ) )
    {
        var9 = "ping_weapon_launcher";
    }
    else if ( var6 == "MP/BR_TYPE_ME_RIOTSHIELD" || var6 == "MP/BR_TYPE_ME_COMBATSHIELD" )
    {
        var9 = "ping_pickup_riotshield";
    }
    else if ( ( issubstr( var6, "_ME" ) || var6 == "MP/BR_TYPE_GENERIC_KN" ) && !issubstr( var6, "_METAL" ) )
    {
        var9 = "ping_weapon_melee";
    }
    else if ( issubstr( var6, "CONCUSSION" ) || issubstr( var6, "DECOY" ) || issubstr( var6, "FLASH" ) || issubstr( var6, "GAS_BR" ) || issubstr( var6, "SMOKE" ) || issubstr( var6, "SNAPSHOT" ) || issubstr( var6, "EMP_GADGET_BR" ) || issubstr( var6, "NUMBERS_GRENADE" ) )
    {
        var9 = "ping_ammo_grenadetactical";
    }
    else if ( issubstr( var6, "HEARTBEAT" ) || issubstr( var6, "BINOCULARS" ) )
    {
        var9 = "ping_pickup_generic";
    }
    else if ( issubstr( var6, "ATMINE" ) || issubstr( var6, "CLAYMORE" ) || issubstr( var6, "C4" ) || issubstr( var6, "FRAG" ) || issubstr( var6, "SEMTEX" ) || issubstr( var6, "THERMITE" ) || issubstr( var6, "THROWING" ) || issubstr( var6, "MOLOTOV" ) )
    {
        var9 = "ping_ammo_grenadelethal";
    }
    else if ( issubstr( var6, "TACTICAL_COVER" ) || issubstr( var6, "TROPHY" ) || issubstr( var6, "RECONDRONE" ) || issubstr( var6, "EMPDRONE" ) || issubstr( var6, "DEADSILENCE" ) || issubstr( var6, "AMMO_DROP" ) || issubstr( var6, "ARMOR_DROP" ) || issubstr( var6, "SUPPORT_BOX" ) || issubstr( var6, "TAC_INSERT" ) || issubstr( var6, "ADVANCED_SUPPLY_DROP" ) || issubstr( var6, "NOVA_BOX" ) || issubstr( var6, "DECON_STATION" ) || issubstr( var6, "KIOSK_DROP" ) || issubstr( var6, "JAMMER" ) || issubstr( var6, "SERUM_GADGET_BR" ) || issubstr( var6, "MP_BR_INGAME_TU_WZ345/SLINGER" ) )
    {
        if ( func_load_difficulty_table( var2, "ping_pickup_fieldupgrade" ) )
        {
            var9 = "ping_pickup_fieldupgrade";
        }
        else
        {
            var9 = "ping_pickup_generic";
        }
    }
    else if ( issubstr( var6, "CONTRACT" ) )
    {
        if ( issubstr( var6, "ASSASSIN" ) )
        {
            var9 = "ping_initial_contract_bounty";
        }
        else if ( issubstr( var6, "DOMINATION" ) )
        {
            var9 = "ping_initial_contract_recon";
        }
        else if ( issubstr( var6, "SCAVENGER" ) )
        {
            var9 = "ping_initial_contract_scavenger";
        }
        else if ( issubstr( var6, "VIP" ) )
        {
            var9 = "ping_initial_contract_mostwanted";
        }
        else if ( issubstr( var6, "EXTRACT" ) )
        {
            var9 = "ping_initial_contract_ctrabandextract";
        }
        else if ( issubstr( var6, "TIMEDRUN" ) )
        {
            var9 = "ping_initial_contract_supplyrun";
        }
        
        if ( var9 != "" && !func_load_difficulty_table( var2, var9 ) )
        {
            var9 = "";
        }
        
        if ( var9 == "" )
        {
            var9 = "ping_pickup_generic";
        }
        
        if ( var9 != "" && !func_load_difficulty_table( var2, var9 ) )
        {
            var9 = "";
        }
        
        if ( var9 == "" )
        {
            var9 = "ping_pickup_generic";
        }
    }
    else if ( issubstr( var6, "GASMASK" ) )
    {
        if ( func_load_difficulty_table( var2, "ping_gasmask" ) )
        {
            var9 = "ping_gasmask";
        }
        else
        {
            var9 = "ping_pickup_generic";
        }
    }
    else if ( issubstr( var6, "RESPAWN_TOKEN" ) || issubstr( var6, "LOOT_CACHE" ) )
    {
        var9 = "ping_pickup_generic";
    }
    else if ( var6 == "EQUIPMENT/ADRENALINE_BR" || var6 == "MP_BR_INGAME/KIOSK_ITEM_SELF_REVIVE" )
    {
        var9 = "ping_pickup_health";
    }
    else if ( var6 == "KILLSTREAKS/MANUAL_TURRET" )
    {
        var9 = "ping_killstreaks_shieldturret_open";
    }
    else if ( issubstr( var6, "ACCESS_CARD" ) )
    {
        if ( func_load_difficulty_table( var2, "ping_loot_accesscard" ) )
        {
            var9 = "ping_loot_accesscard";
        }
        else
        {
            var9 = "ping_pickup_generic";
        }
    }
    else if ( issubstr( var6, "KILLSTREAK" ) || var6 == "SATELLITE_HUNT/HARP" )
    {
        var9 = "ping_pickup_generic";
    }
    else if ( issubstr( var6, "_PLUNDER_EXTRACT" ) )
    {
        if ( func_load_difficulty_table( var2, "ping_cash_deposit_balloon" ) )
        {
            var9 = "ping_cash_deposit_balloon";
        }
        else
        {
            var9 = "ping_plunder_bank";
        }
    }
    else if ( issubstr( var6, "COOP_CRAFTING" ) )
    {
        var9 = "ping_pickup_generic";
    }
    else if ( issubstr( var6, "SPECIALISTBONUS" ) )
    {
        var9 = "ping_pickup_generic";
    }
    else if ( issubstr( var6, "CARGOTRAIN" ) )
    {
        var9 = "ping_location_generic";
    }
    else if ( issubstr( var6, "TRAMWAY" ) )
    {
        var9 = "ping_location_generic";
    }
    else if ( issubstr( var6, "GONDOLA" ) )
    {
        var9 = "ping_location_generic";
    }
    else if ( issubstr( var6, "LOOT_CARD_X1_CYPHER_TITLE" ) )
    {
        var9 = "ping_pickup_generic";
    }
    else if ( issubstr( var6, "ESCAPE_RADIO" ) )
    {
        var9 = "ping_pickup_generic";
    }
    else if ( issubstr( var6, "LOOT_CARD_X2_TNT_TITLE" ) )
    {
        var9 = "ping_pickup_generic";
    }
    else if ( issubstr( var6, "X2_LEGEND_TRAIN" ) )
    {
        var9 = "ping_pickup_generic";
    }
    else if ( issubstr( var6, "R2_TACTICAL_DEVICE" ) )
    {
        var9 = "ping_pickup_generic";
    }
    else if ( issubstr( var6, "ADVANCED_VEHICLE_DROP" ) )
    {
        var9 = "ping_pickup_generic";
    }
    else if ( issubstr( var6, "DOGTAG_TITLE" ) )
    {
        var9 = "ping_pickup_generic";
    }
    else if ( issubstr( var6, "VAULT_KEYCARD" ) )
    {
        var9 = "ping_pickup_generic";
    }
    else if ( issubstr( var6, "RBRTH_LOCKER_KEYCARD" ) )
    {
        var9 = "ping_pickup_generic";
    }
    else if ( issubstr( var6, "REWARD_EXTRA_LIFE" ) )
    {
        var9 = "ping_pickup_generic";
    }
    else if ( issubstr( var6, "GASOLINE_CAN_MP" ) )
    {
        var9 = "ping_ammo_grenadelethal";
    }
    else if ( issubstr( var6, "SPEED_BOOST" ) )
    {
        var9 = "ping_pickup_generic";
    }
    else if ( issubstr( var6, "KILLMONGER" ) )
    {
        var9 = "ping_pickup_generic";
    }
    else if ( issubstr( var6, "DOUBLE_POINTS" ) )
    {
        var9 = "ping_pickup_generic";
    }
    else if ( issubstr( var6, "PERKS" ) )
    {
        var9 = "ping_pickup_generic";
    }
    else if ( issubstr( var6, "PERKPOINT" ) )
    {
        var9 = "ping_pickup_generic";
    }
    else if ( issubstr( var6, "TOKEN" ) )
    {
        var9 = "ping_pickup_generic";
    }
    else if ( issubstr( var6, "ZXP" ) )
    {
        var9 = "ping_pickup_generic";
    }
    else if ( issubstr( var6, "MP_BR_INGAME_TU_WZ350/BR_BOMBSITE" ) )
    {
        var9 = "ping_location_generic";
    }
    else if ( issubstr( var6, "MP_BR_INGAME_TU_WZ350/BR_BOMB" ) )
    {
        var9 = "ping_pickup_generic";
    }
    else if ( issubstr( var6, "MP_BR_INGAME_TU_WZ350/BR_DEFUSEKIT" ) )
    {
        var9 = "ping_pickup_generic";
    }
    else if ( issubstr( var6, "MP_BR_INGAME_TU_WZ350/BR_DOOMSTATION" ) )
    {
        var9 = "ping_pickup_generic";
    }
    
    return var9;
}

// Params 3
// Size: 0x220
function fusefx( var0, var1, var2 )
{
    var3 = self;
    
    if ( isdefined( var1 ) && isdefined( var1.type ) )
    {
        var4 = var1.type;
    }
    else
    {
        return "";
    }
    
    var5 = 0;
    var6 = tablelookupgetnumrows( level.brloottablename );
    var7 = undefined;
    
    for ( var8 = var5; var8 < var6 ; var8++ )
    {
        var9 = tablelookupbyrow( level.brloottablename, var8, 1 );
        
        if ( var9 == var4 )
        {
            var7 = tablelookupbyrow( level.brloottablename, var8, 12 );
            
            if ( var7 == "" )
            {
            }
            
            break;
        }
    }
    
    if ( !isdefined( var7 ) )
    {
        if ( var4 == "brloot_plunder_extraction_site_01" || var4 == "brloot_plunder_extraction_site_02" || var4 == "equip_fulton_mp" )
        {
            if ( func_load_difficulty_table( var2, "ping_plunder_bank_confirm" ) )
            {
                return "ping_plunder_bank_confirm";
            }
        }
        
        return "ping_dibs";
    }
    
    var10 = "";
    
    if ( issubstr( var7, "CONTRACT" ) )
    {
        if ( issubstr( var7, "ASSASSIN" ) )
        {
            var10 = "ping_affirm_contract_bounty";
        }
        else if ( issubstr( var7, "DOMINATION" ) )
        {
            var10 = "ping_affirm_contract_recon";
        }
        else if ( issubstr( var7, "SCAVENGER" ) )
        {
            var10 = "ping_affirm_contract_scavenger";
        }
        else if ( issubstr( var7, "VIP" ) )
        {
            var10 = "ping_affirm_contract_mostwanted";
        }
        else if ( issubstr( var7, "EXTRACT" ) )
        {
            var10 = "ping_affirm_contract_ctrabandextract";
        }
        else if ( issubstr( var7, "TIMEDRUN" ) )
        {
            var10 = "ping_affirm_contract_supplyrun";
        }
        
        if ( var10 != "" && !func_load_difficulty_table( var2, var10 ) )
        {
            var10 = "";
        }
        
        if ( var10 == "" )
        {
            var10 = "ping_affirm_contract_generic";
        }
        
        if ( var10 != "" && !func_load_difficulty_table( var2, var10 ) )
        {
            var10 = "";
        }
    }
    else if ( issubstr( var7, "GASMASK" ) )
    {
        if ( func_load_difficulty_table( var2, "ping_gasmask_confirm" ) )
        {
            var10 = "ping_gasmask_confirm";
        }
    }
    else if ( issubstr( var7, "ARMORY_KIOSK" ) )
    {
        if ( func_load_difficulty_table( var2, "ping_plunder_vendor_confirm" ) )
        {
            var10 = "ping_plunder_vendor_confirm";
        }
    }
    else if ( issubstr( var7, "_PLUNDER_EXTRACT" ) )
    {
        if ( func_load_difficulty_table( var2, "ping_cash_deposit_confirm" ) )
        {
            var10 = "ping_cash_deposit_confirm";
        }
    }
    
    if ( var10 == "" )
    {
        var10 = "ping_dibs";
    }
    
    return var10;
}

// Params 1
// Size: 0x68
function calloutmarkerping_removecallout( var0 )
{
    var1 = self;
    
    if ( !isdefined( var1 ) )
    {
        return;
    }
    
    addquestrewardtier( "Remove Callout ID Start: " + var0 );
    
    if ( isdefined( var0 ) )
    {
        if ( var0 == 0 )
        {
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "ping", "calloutMarkerPing_squadLeaderBeaconKillForPlayer" ) )
            {
                [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "ping", "calloutMarkerPing_squadLeaderBeaconKillForPlayer" ) ]]( var1 );
            }
        }
        
        var1 calloutmarkerping_delete( var0 );
        addquestrewardtier( "Remove Callout ID Notify: " + var0 );
        var1 notify( "predictiveCalloutClear_" + var0 );
        return;
    }
}

// Params 2
// Size: 0x50
function fulton_refundsuper( var0, var1 )
{
    self endon( "disconnect" );
    self endon( "predictiveCalloutClear_" + var0 );
    
    for ( ;; )
    {
        level waittill( "Objective_SetShowProgress", var2 );
        
        if ( isdefined( var2 ) && var2 == var1 )
        {
            addquestrewardtier( "gscObjectiveStartedProgress: " + var0 + " | gscObjID: " + var1 );
            break;
        }
    }
    
    calloutmarkerping_removecallout( var0 );
}

// Params 2
// Size: 0x50
function fulton_planted( var0, var1 )
{
    self endon( "disconnect" );
    self endon( "predictiveCalloutClear_" + var0 );
    
    for ( ;; )
    {
        level waittill( "Objective_Delete", var2 );
        
        if ( isdefined( var2 ) && var2 == var1 )
        {
            addquestrewardtier( "gscObjectiveDeleted: " + var0 + " | gscObjID: " + var1 );
            break;
        }
    }
    
    calloutmarkerping_removecallout( var0 );
}

// Params 2
// Size: 0x6f
function fulton_interactions_disabled( var0, var1 )
{
    self endon( "disconnect" );
    self endon( "predictiveCalloutClear_" + var0 );
    addquestrewardtier( "Watch Entity Death or Enemy Disconnect: " + var0 );
    
    if ( !isdefined( var1 ) )
    {
    }
    else if ( isplayer( var1 ) )
    {
        var1 waittill( "disconnect" );
    }
    else
    {
        var1 scripts\engine\utility::ref_143a6( "death", "pickup", "explode" );
    }
    
    if ( isdefined( var1.update_bomb_vest_lua ) )
    {
        var1.update_bomb_vest_lua = undefined;
    }
    
    calloutmarkerping_removecallout( var0 );
}

// Params 2
// Size: 0x46
function fulton_open( var0, var1 )
{
    self endon( "predictiveCalloutClear_" + var0 );
    addquestrewardtier( "watchPlayerDeathOrDisconnect: " + var0 );
    var2 = remove_prohibited_weapons( var1 );
    
    if ( var2 != "unsupported" )
    {
        scripts\engine\utility::ref_143a5( "death_or_disconnect", "self_pickedupitem_" + var2 );
    }
    
    calloutmarkerping_removecallout( var0 );
}

// Params 2
// Size: 0xe4
function calloutmarkerping_watchscriptabledeath( var0, var1 )
{
    self endon( "disconnect" );
    self endon( "predictiveCalloutClear_" + var0 );
    addquestrewardtier( "Watch scriptable death ID: " + var0 );
    
    if ( !isdefined( var1 ) )
    {
    }
    else if ( var1.type == "equip_fulton_mp" )
    {
        var2 = var1.entity;
        
        if ( !isdefined( var2 ) )
        {
            return;
        }
        
        var2 scripts\engine\utility::ref_143a5( "death", "fulton_takeoff" );
    }
    else if ( var1.type == "br_plunder_box" )
    {
        var1 waittill( "kiosk_disabled" );
    }
    else
    {
        level scripts\engine\utility::ref_143a8( "pickedupweapon_kill_callout_" + var1.type + var1.origin, "lootcache_opened_kill_callout" + var1.origin, "dropbag_kill_callout_" + var1.origin, "tablethide_kill_callout_" + var1.origin, "carriable_kill_callout_" + var1.origin );
    }
    
    addquestrewardtier( "Watch scriptable death Remove ID: " + var0 );
    calloutmarkerping_removecallout( var0 );
}

// Params 1
// Size: 0x154
function fulton_actors( var0 )
{
    var1 = self;
    
    if ( addleadobjective( var0 ) )
    {
        var2 = getdvarfloat( "scr_calloutmarkerping_death_timeout_navigation", 120 );
    }
    else if ( addpostlaunchspawns( var1 ) )
    {
        if ( addjuggfunctionality( var1 ) )
        {
            var2 = getdvarfloat( "scr_calloutmarkerping_death_timeout_navigation", 120 );
        }
        else if ( fulton_check_for_moving_platform( var2 ) )
        {
            var2 = getdvarfloat( "scr_calloutmarkerping_death_timeout_quest_loot", 120 );
        }
        else
        {
            var2 = getdvarfloat( "scr_calloutmarkerping_death_timeout_loot", 30 );
        }
    }
    else if ( addplundercarrycredit( var2 ) )
    {
        if ( addjuggfunctionality( var2 ) )
        {
            var2 = getdvarfloat( "scr_calloutmarkerping_death_timeout_navigation", 120 );
        }
        else
        {
            var2 = getdvarfloat( "scr_calloutmarkerping_death_timeout_entity", 60 );
        }
    }
    else if ( addplayeraslootleader( var2 ) )
    {
        var2 = getdvarfloat( "scr_calloutmarkerping_death_timeout_danger", 15 );
    }
    else
    {
        switch ( var2 )
        {
            case 0:
                var2 = getdvarfloat( "scr_calloutmarkerping_death_timeout_navigation", 120 );
                break;
            case 7:
                var2 = getdvarfloat( "scr_calloutmarkerping_death_timeout_world", 120 );
                break;
            case 8:
                var2 = getdvarfloat( "scr_calloutmarkerping_death_timeout_vehicle", 60 );
                break;
            case 12:
                var2 = getdvarfloat( "scr_calloutmarkerping_death_timeout_request", 30 );
                break;
            default:
                var2 = 2;
                break;
        }
    }
    
    return var2;
}

// Params 1
// Size: 0x11
function calloutmarkerping_onplayerdisconnect( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    fulton_exfil_model( var0 );
}

// Params 2
// Size: 0x84
function fulton_repositorycountdownendcallback( var0, var1 )
{
    var2 = self;
    
    if ( addpostlaunchspawns( var0 ) )
    {
        return ( var1 + 500 );
    }
    
    if ( addplundercarrycredit( var0 ) )
    {
        return ( var1 + 500 );
    }
    
    if ( addplayeraslootleader( var0 ) )
    {
        return ( var1 + 500 );
    }
    
    switch ( var0 )
    {
        case 0:
            return ( var1 + 500 );
        case 8:
            return ( var1 + 500 );
        case 7:
            return ( var1 + 500 );
        case 12:
            return ( var1 + 500 );
        default:
            break;
    }
}

// Params 1
// Size: 0x19, Type: bool
function fxangles( var0 )
{
    var1 = self;
    
    if ( !isdefined( var1.fxrings[ var0 ] ) )
    {
        return false;
    }
    
    return true;
}

// Params 4
// Size: 0x5c, Type: bool
function fx_thermal_end( var0, var1, var2, var3 )
{
    var4 = self;
    var5 = var4.fxrings.size;
    
    if ( var5 > 10 )
    {
        return false;
    }
    
    var6 = fulton_repositorycountdownendcallback( var4, var0, var3 );
    var7 = var6 + var1;
    var8 = spawnstruct();
    var8.ref_134e0 = var7;
    var8.poolid = var0;
    var8.generatenumbercode_array = 0;
    var4.fxrings[ var2 ] = var8;
    return true;
}

// Params 3
// Size: 0xbe
function fulton_repositoryextractcallback( var0, var1, var2 )
{
    var3 = self;
    
    if ( !isdefined( var3 ) || !isplayer( var3 ) )
    {
        return 0;
    }
    
    if ( istrue( var3.loadout_updateglobalclassstruct ) )
    {
        return 0;
    }
    
    var4 = gettime();
    var5 = "pool" + var0;
    var6 = fxangles( var3, var5 );
    
    if ( var6 )
    {
        var7 = var3.fxrings[ var5 ].ref_134e0;
        
        if ( var4 >= var7 )
        {
            var8 = fx_thermal_end( var3, var0, var4, var5, var2 );
            return istrue( var8 );
        }
        
        if ( var2 == "ping_response_cancel" && var4.fxrings[ var6 ].generatenumbercode_array == 0 )
        {
            var4.fxrings[ var6 ].generatenumbercode_array = 1;
            return 1;
        }
        
        return 0;
    }
    
    if ( var3 == "ping_response_cancel" )
    {
        return 0;
    }
    
    var8 = fx_thermal_end( var5, var2, var6, var7, var4 );
    return istrue( var8 );
}

// Params 0
// Size: 0x8d
function fulton_used()
{
    level endon( "game_ended" );
    
    for ( ;; )
    {
        wait 10;
        var0 = gettime();
        
        for ( var1 = 0; var1 < level.players.size ; var1++ )
        {
            var2 = level.players[ var1 ];
            
            if ( !isdefined( var2 ) || !isdefined( var2.fxrings ) )
            {
                continue;
            }
            
            foreach ( var4 in var2.fxrings )
            {
                if ( var0 > var4.ref_134e0 )
                {
                    var2.fxrings[ var5 ] = undefined;
                }
            }
        }
    }
}

// Params 4
// Size: 0x3a
function fx_thermal( var0, var1, var2, var3 )
{
    var4 = 0;
    
    if ( var0 )
    {
        var5 = lookupsoundlength( var1, 1 );
        
        if ( var5 > var4 )
        {
            var4 = var5;
        }
    }
    
    if ( var2 )
    {
        var5 = lookupsoundlength( var3, 1 );
        
        if ( var5 > var4 )
        {
            var4 = var5;
        }
    }
    
    return var4;
}

// Params 0
// Size: 0x4, Type: bool
function calloutmarkerping_getpoolidnavigation()
{
    return false;
}

// Params 2
// Size: 0x159
function fulton_deletenextframe( var0, var1 )
{
    var2 = self;
    
    if ( !isdefined( var2 ) || !isplayer( var2 ) || !isdefined( var0 ) )
    {
        return;
    }
    
    if ( soundexists( var0 ) )
    {
    }
    
    var3 = var2 calloutmarkerping_getsavedzoffset( var1 );
    var4 = var2 setallstreamloaddist( var1 );
    var5 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "getFriendlyPlayers" ) ]]( var2.team, 1 );
    
    foreach ( var7 in var5 )
    {
        if ( istrue( var7.gulag ) )
        {
            continue;
        }
        
        if ( var2 isspectatingplayer() )
        {
            var8 = var7;
        }
        else if ( isdefined( var3 ) )
        {
            var8 = spawn( "script_origin", var3.origin );
            var8.validatedamagerelicswat = 1;
        }
        else if ( isdefined( var4 ) )
        {
            var8 = spawn( "script_origin", var4 );
            var8.validatedamagerelicswat = 1;
        }
        else
        {
            var8 = var2;
        }
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "playSoundToSquad" ) )
        {
            var8 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "playSoundToSquad" ) ]]( var0, var2.team, var2 );
        }
        else
        {
            var8 playsoundtoteam( var0, var2.team );
        }
        
        if ( isdefined( var8.validatedamagerelicswat ) )
        {
            var8 delete();
        }
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "squadAsTeamEnabled" ) && [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "squadAsTeamEnabled" ) ]]() )
        {
            break;
        }
    }
}

// Params 1
// Size: 0x2c, Type: bool
function func_load_difficulty_table( var0 )
{
    var1 = self;
    var2 = fx_model( var1, var0 );
    var3 = fx_obj( var1, var0 );
    var4 = soundexists( var2 );
    var5 = soundexists( var3 );
    return var4 || var5;
}

// Params 1
// Size: 0x65
function fx_model( var0 )
{
    var1 = self;
    
    if ( !isdefined( var1.operatorcustomization ) || !isdefined( var1.operatorcustomization.voice ) )
    {
        return;
    }
    
    var2 = "dx_mpp_" + var1.operatorcustomization.voice + "_" + var0;
    
    if ( var2 == "dx_mpp_gar_ping_pickup_fieldupgrade" )
    {
        var2 = "dx_mpp_gar_ping_pickup_fieldupgrade_hash";
    }
    
    if ( var2 == "dx_mpp_asad_ping_affirm_contract_recon" )
    {
        var2 = "dx_mpp_asad_ping_affirm_contract_recon_hash";
    }
    
    return var2;
}

// Params 1
// Size: 0x45
function fx_obj( var0 )
{
    var1 = self;
    
    if ( !isdefined( var1.operatorcustomization ) || !isdefined( var1.operatorcustomization.voice ) )
    {
        return;
    }
    
    var2 = "dx_mpb_" + var1.operatorcustomization.voice + "_" + var0;
    return var2;
}

// Params 3
// Size: 0x178
function fxent2( var0, var1, var2 )
{
    var3 = self;
    
    if ( !isdefined( var3 ) || !isplayer( var3 ) )
    {
        return;
    }
    
    if ( !isdefined( var1 ) )
    {
        return;
    }
    
    if ( !isdefined( var0 ) || var0 == "" )
    {
        return;
    }
    
    if ( isplayer( var2 ) )
    {
        var4 = var2;
    }
    else
    {
        var4 = var4;
    }
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "skipPlayerVO" ) && [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "skipPlayerVO" ) ]]( var4 ) )
    {
        return;
    }
    
    var5 = fx_model( var4, var1 );
    var6 = fx_obj( var4, var1 );
    var7 = soundexists( var5 );
    var8 = soundexists( var6 );
    var9 = fx_thermal( var7, var5, var8, var6 );
    var10 = fulton_repositoryextractcallback( var4, var2, var1, var9 );
    
    if ( istrue( var10 ) )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "squadAsTeamEnabled" ) && [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "squadAsTeamEnabled" ) ]]() )
        {
            var11 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "getSquadPlayers" ) ]]( var4.team, var4.squadindex );
        }
        else
        {
            var11 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "getFriendlyPlayers" ) ]]( var4.team, 1 );
        }
        
        foreach ( var13 in var11 )
        {
            if ( istrue( var13.gulag ) )
            {
                continue;
            }
            
            if ( var5 == var13 || var5 isspectatingplayer() )
            {
                if ( var8 )
                {
                    var5 playsoundtoplayer( var6, var13, var13 );
                }
                
                continue;
            }
            
            if ( var9 )
            {
                var5 playsoundtoplayer( var7, var13 );
            }
        }
    }
    
    if ( !var9 )
    {
        return;
    }
}

// Params 0
// Size: 0x103
function fulton_create()
{
    self endon( "disconnect" );
    self endon( "predictiveCalloutClear_0" );
    self notify( "calloutMarkerPing_navigationCancelProximity" );
    self endon( "calloutMarkerPing_navigationCancelProximity" );
    var0 = getdvarfloat( "scr_calloutmarkerping_death_timeout_navigation", 120 );
    var1 = getdvarint( "scr_calloutmarkerping_navigation_cancel_minimum_time_secs", 10 );
    wait var1;
    
    if ( !self calloutmarkerping_getfeedback( 0 ) )
    {
        return;
    }
    
    var2 = self setallstreamloaddist( 0 );
    var3 = getdvarint( "scr_calloutmarkerping_navigation_proximity_cancel_dist_sq", 47089 );
    var4 = getdvarint( "scr_calloutmarkerping_navigation_proximity_cancel_type", 1 );
    var5 = getdvarint( "scr_calloutmarkerping_navigation_proximity_cancel_tick_secs", 1 );
    
    for ( ;; )
    {
        if ( var4 == 1 )
        {
            var6 = distancesquared( self.origin, var2 );
        }
        else
        {
            var6 = var3;
            var7 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "getFriendlyPlayers" ) ]]( self.team, 1 );
            
            foreach ( var9 in var7 )
            {
                var10 = distancesquared( var9.origin, var2 );
                
                if ( var10 < var6 )
                {
                    var6 = var10;
                }
            }
        }
        
        if ( var6 < var3 )
        {
            fulton_deletenextframe( "br_ping_cancel", 0 );
            calloutmarkerping_removecallout( 0 );
            return;
        }
        
        wait var5;
    }
}

// Params 0
// Size: 0x23
function fulton_exfil_model()
{
    var0 = self;
    
    if ( isdefined( var0 ) )
    {
        for ( var1 = 0; var1 < 13 ; var1++ )
        {
            calloutmarkerping_removecallout( var0, var1 );
        }
        
        return;
    }
}

// Params 1
// Size: 0x46
function fulton_destroy( var0 )
{
    var1 = 0;
    
    foreach ( var3 in level.players )
    {
        fulton_exfil_model( var3 );
        
        if ( istrue( var0 ) )
        {
            var1++;
            
            if ( var1 % 10 == 0 )
            {
                waitframe();
            }
        }
    }
}

// Params 1
// Size: 0x44
function fxorigintagb( var0 )
{
    var1 = self;
    var1 notify( "calloutMarkerPingVO_playPredictivePingCleared" );
    var1 endon( "calloutMarkerPingVO_playPredictivePingCleared" );
    fulton_deletenextframe( var1, "br_ping_cancel", var0 );
    wait getdvarfloat( "scr_calloutmarkerping_delay_between_vo_and_sfx_secs_cleared", 0.5 );
    
    if ( isdefined( var1 ) )
    {
        fxent2( var1, "ping_response_cancel", var0 );
        return;
    }
}

// Params 1
// Size: 0xf
function fxorigin( var0 )
{
    var1 = self;
    fxorigintagb( var1, var0 );
}

// Params 2
// Size: 0x131
function fxgreen( var0, var1 )
{
    var2 = self;
    var2 notify( "calloutMarkerPingVO_playPredictivePingAcknowledged" );
    var2 endon( "calloutMarkerPingVO_playPredictivePingAcknowledged" );
    
    if ( addpostlaunchspawns( var0 ) )
    {
        var3 = var2 calloutmarkerping_getsavedzoffset( var0 );
        var4 = fusefx( var2, var0, var3, var1 );
    }
    else if ( addplundercarrycredit( var1 ) )
    {
        var4 = "ping_response_affirm";
    }
    else if ( addplayeraslootleader( var2 ) )
    {
        var4 = "ping_response_copy";
    }
    else
    {
        switch ( var4 )
        {
            case 0:
                if ( func_load_difficulty_table( var4, "ping_generic_ping_response" ) )
                {
                    var4 = "ping_generic_ping_response";
                }
                else
                {
                    var4 = "ping_response_affirm";
                }
                
                break;
            case 7:
                var4 = "ping_response_copy";
                break;
            case 8:
                if ( func_load_difficulty_table( var4, "ping_vehicle_confirm" ) )
                {
                    var4 = "ping_vehicle_confirm";
                }
                else
                {
                    var4 = "ping_response_affirm";
                }
                
                break;
            case 12:
                var4 = "ping_dibs";
                break;
            default:
                var4 = "ping_response_affirm";
                break;
        }
    }
    
    wait getdvarfloat( "scr_calloutmarkerping_delay_between_vo_and_sfx_secs_acked", 0.5 );
    
    if ( isplayer( var4 ) )
    {
        fxent2( var4, var4, var4, var4 );
        return;
    }
    
    if ( isdefined( var4 ) )
    {
        fxent2( var4, var4, var4 );
        return;
    }
}

// Params 1
// Size: 0x42
function fxorigintag( var0 )
{
    var1 = self;
    var1 notify( "calloutMarkerPingVO_playPredictivePingAdded" );
    var1 endon( "calloutMarkerPingVO_playPredictivePingAdded" );
    var1 endon( "calloutMarkerPingVO_playPredictivePingCleared" );
    var1 endon( "predictiveCalloutClear_" + var0 );
    wait getdvarfloat( "scr_calloutmarkerping_delay_between_vo_and_sfx_secs_added", 0.5 );
    
    if ( isdefined( var1 ) )
    {
        fulton_repositoryusecallback( var1, var0 );
        return;
    }
}

// Params 1
// Size: 0x24, Type: bool
function fulton_check_for_moving_platform( var0 )
{
    var1 = self;
    var2 = var1 calloutmarkerping_getsavedzoffset( var0 );
    
    if ( isdefined( var2 ) && isdefined( var2.ref_139eb ) )
    {
        return true;
    }
    
    return false;
}

// Params 1
// Size: 0x5a
function addjuggfunctionality( var0 )
{
    var1 = self;
    var2 = var1 calloutmarkerping_getsavedzoffset( var0 );
    
    if ( isdefined( var2 ) && isdefined( var2.classname ) && issubstr( var2.classname, "scriptable" ) && !isdefined( var2.entity ) && var2 getscriptableisreserved() )
    {
        if ( var2 method_87b9() )
        {
            var3 = var2 method_87b7();
            return _calloutmarkerping_handleluinotify_enemyrepinged::trophy_tryreflectsnapshot( var3 );
        }
    }
    
    return 0;
}

// Params 1
// Size: 0x36, Type: bool
function addleadobjective( var0 )
{
    var1 = self;
    var2 = var1 calloutmarkerping_getsavedzoffset( var0 );
    
    if ( isdefined( var2 ) && isdefined( var2.vehiclename ) && issubstr( var2.vehiclename, "train" ) )
    {
        return true;
    }
    
    return false;
}

// Params 2
// Size: 0x81
function fulton_handledamage( var0, var1 )
{
    self endon( "disconnect" );
    self endon( "predictiveCalloutClear_" + var0 );
    var2 = 0.25;
    var3 = 0;
    var4 = self.team;
    
    for ( ;; )
    {
        var5 = addselfrevivetoken( var0, var1, var4 );
        
        if ( var5 )
        {
            calloutmarkerping_removecallout( var0 );
            return;
        }
        
        var6 = addplatepouch( var1, var4 );
        
        if ( var6 )
        {
            var3 += var2;
            
            if ( var3 >= 3 )
            {
                var7 = var1 getvehicleowner();
                
                if ( isdefined( var7 ) )
                {
                    thread fulton_ac130_model( var0, var7 );
                    return;
                }
                
                calloutmarkerping_removecallout( var0 );
                return;
            }
        }
        
        wait var3;
    }
}

// Params 3
// Size: 0x71, Type: bool
function addselfrevivetoken( var0, var1, var2 )
{
    var3 = self;
    var4 = 0;
    var5 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "getFriendlyPlayers" ) ]]( var2, 1 );
    
    foreach ( var7 in var5 )
    {
        if ( var7 scripts\cp_mp\utility\player_utility::isinvehicle() && var7.vehicle == var1 )
        {
            var3 calloutmarkerping_hide( var0, var7 );
            var4++;
        }
    }
    
    if ( var4 == var5.size )
    {
        return true;
    }
    
    return false;
}

// Params 2
// Size: 0x3f, Type: bool
function addplatepouch( var0, var1 )
{
    var2 = isdefined( var0.ownerteam ) && var0.ownerteam != var1;
    var3 = isdefined( var0.isempty ) && var0.isempty == 0;
    
    if ( var3 && var2 )
    {
        return true;
    }
    
    return false;
}

// Params 1
// Size: 0x12a
function add_trigger_to_oob_system( var0 )
{
    var1 = self;
    
    if ( !isdefined( var1.fulton_repositoryatcapacitycallback ) )
    {
        var1.fulton_repositoryatcapacitycallback = [];
    }
    
    if ( !isdefined( var1.fulton_repositoryatcapacitycallback[ var0 ] ) )
    {
        var1.fulton_repositoryatcapacitycallback[ var0 ] = 0;
    }
    else
    {
        var1.fulton_repositoryatcapacitycallback[ var0 ]++;
    }
    
    var2 = [];
    GscBinSkip0( 0x2e, var2.size, "ping_id" );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 0
// Size: 0x30
function add_wave_overrides_to_module()
{
    var0 = self;
    
    if ( isdefined( var0 ) )
    {
        for ( var1 = 0; var1 < 13 ; var1++ )
        {
            if ( var0 calloutmarkerping_getfeedback( var1 ) )
            {
                add_veh_spawners_to_passive_wave_spawning( var0, var1, "clear_all" );
            }
        }
        
        return;
    }
}

// Params 2
// Size: 0xc7
function add_veh_spawners_to_passive_wave_spawning( var0, var1 )
{
    var2 = self;
    
    if ( !isdefined( var2.fulton_repositoryatcapacitycallback ) )
    {
        return;
    }
    
    if ( !isdefined( var2.fulton_repositoryatcapacitycallback[ var0 ] ) )
    {
        return;
    }
    
    var3 = [];
    GscBinSkip0( 0x2e, var3.size, "ping_id" );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 1
// Size: 0x26
function addbattlepassxpmultiplier( var0 )
{
    var1 = self;
    add_veh_spawners_to_passive_wave_spawning( var1, var0, "clear_single" );
    var1 notify( "predictiveCalloutClear_" + var0 );
    thread fxorigintagb( var1 );
}

// Params 2
// Size: 0x5a
function addaccesscard( var0, var1 )
{
    var2 = self;
    thread addquestrewardtierframeend( var2, var0, 0 );
    thread fxgreen( var2, var0 );
    
    if ( getdvarint( "OMSQPMNQLS", 0 ) && istrue( level.onlinestatsenabled ) && isdefined( var2.usingonlinedataoffline ) && !var2.usingonlinedataoffline )
    {
        var2 setplayerdata( "mp", "use_ping_ack_history", 0, 1 );
        return;
    }
}

// Params 1
// Size: 0xf
function addaliasarraytoqueue( var0 )
{
    var1 = self;
    thread fxorigin( var1 );
}

// Params 1
// Size: 0x121
function addallkillstreaksunlocked( var0 )
{
    var1 = self;
    
    if ( istrue( level.stop_end_breach_fx ) && !istrue( var1 setadditionalstreamloaddist() ) )
    {
        calloutmarkerping_removecallout( var0 );
        return;
    }
    
    add_trigger_to_oob_system( var1, var0 );
    thread addquestrewardtierframeend( var1 );
    add_track_points( var1, var0 );
    thread fxorigintag( var1 );
    addplayerasexpiredlootleader( var1, var0 );
    
    if ( var0 == 7 )
    {
        var2 = self getnodeoffset_code( var0 );
        var3 = 1;
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "shouldPingDisableObjectiveIntro" ) )
        {
            var3 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "shouldPingDisableObjectiveIntro" ) ]]( var2 );
        }
        
        if ( var2 != -1 && var3 )
        {
            objective_setplayintro( var2, 0 );
        }
    }
    
    if ( getdvarint( "OMSQPMNQLS", 0 ) && istrue( level.onlinestatsenabled ) && isdefined( var1.usingonlinedataoffline ) && !var1.usingonlinedataoffline )
    {
        var1 setplayerdata( "mp", "use_ping_history", 0, 1 );
        
        if ( addplundercarrycredit( var0 ) )
        {
            var4 = var1 calloutmarkerping_getsavedzoffset( var0 );
            
            if ( isdefined( var4 ) )
            {
                var1 setplayerdata( "mp", "use_ping_enemy_history", 0, 1 );
            }
        }
    }
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "onPing" ) )
    {
        var1 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "onPing" ) ]]( var0 );
        return;
    }
}

// Params 1
// Size: 0x1f
function adddroponplayerdeath( var0 )
{
    var1 = self;
    thread addquestrewardtierframeend( var1, var0, 0 );
    fulton_deletenextframe( var1, "br_ping_enemy", var0 );
}

// Params 0
// Size: 0x3a
function addedcollision()
{
    var0 = self;
    var1 = addpowerbutton();
    
    if ( var1 != -1 )
    {
        add_wave_overrides_to_module( var0 );
        fulton_deletenextframe( var0, "br_ping_cancel", var1 );
        fxent2( var0, "ping_response_cancel", var1 );
    }
    
    fulton_exfil_model( var0 );
}

// Params 1
// Size: 0xf
function addallkillstreaksunlockedinonelife( var0 )
{
    var1 = self;
    thread fulton_handlefataldamage( var1 );
}

