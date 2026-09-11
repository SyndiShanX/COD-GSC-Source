
// Params 0
// Size: 0x128
function init()
{
    level.debug_trap_room = spawnstruct();
    level.debug_trap_room.scriptables = [];
    level.debug_trap_toggle = getdvarint( "scr_br_armory_trader", 0 ) != 0;
    
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "trader" ) )
    {
        level.debug_trap_toggle = 0;
    }
    else
    {
        var0 = registeraccesscardlocs();
        
        if ( !isdefined( var0 ) || var0.size == 0 )
        {
            level.debug_trap_toggle = 0;
        }
    }
    
    if ( !level.debug_trap_toggle )
    {
        return;
    }
    
    scripts\engine\scriptable::ref_12f5b( "br_armory_trader", &camera_loadout_showcase_preview_large_sticker_alt1 );
    level.debug_trap_room.ref_11a20 = strtok( getdvar( "MSLKNNLLMN", "" ), "|" );
    level.debug_trap_room.play_lighting_sequence = strtok( getdvar( "scr_br_armory_trader_filter", "brloot_offhand_advancedsupplydrop|brloot_plunder_extract|brloot_perk_point_overkill" ), "|" );
    logtraderfilter();
    tr_detectwinners();
    level.debug_trap_room.xp = [ 0, 100, 200, 300, 500 ];
    level.debug_trap_room.ref_140a2 = [ 1, 2.5, 3, 3.5, 5 ];
    level.debug_trap_room.ref_1409a = [ "WTS_rarity_common", "WTS_rarity_uncommon", "WTS_rarity_rare", "WTS_rarity_epic", "WTS_rarity_legendary" ];
}

// Params 0
// Size: 0x64
function logtraderfilter()
{
    var0 = getdvar( "scr_br_armory_trader_filter", "undefined_default" );
    logstring( "br_armory_trader scr_br_armory_trader_filter value is: " + var0 );
    var1 = "";
    
    foreach ( var3 in level.debug_trap_room.play_lighting_sequence )
    {
        var1 += var3 + " ";
    }
    
    logstring( "br_armory_trader level.br_armory_trader.filteredItems value is: " + var1 );
}

// Params 0
// Size: 0x33
function tr_detectwinners()
{
    level.debug_trap_room.ref_13c65 = [];
    level.debug_trap_room.ref_13c65[ "default" ] = tmtyl_bomber_squadafterspawnfunc( getdvar( "scr_br_armory_trader_options", "mp/brTraderOptions.csv" ) );
}

// Params 1
// Size: 0x12b
function tmtyl_bomber_squadafterspawnfunc( var0 )
{
    var1 = [];
    var2 = undefined;
    var3 = undefined;
    var4 = tablelookupgetnumrows( var0 );
    
    for ( var5 = 0; var5 < var4 ; var5++ )
    {
        var6 = tablelookupbyrow( var0, var5, 0 );
        
        if ( !isdefined( var6 ) || var6 == "" )
        {
            continue;
        }
        
        if ( var6 == "1" )
        {
            if ( !isdefined( var3 ) || var3 != var6 )
            {
                var2 = spawnstruct();
                var2.ref_13a31 = [];
                var2.entries = [];
                var1 = scripts\engine\utility::array_add( var1, var2 );
            }
            
            var2.ref_13a31[ var2.ref_13a31.size ] = tablelookupbyrow( var0, var5, 1 );
        }
        else if ( var6 == "2" && isdefined( var2 ) )
        {
            var7 = spawnstruct();
            var7.weight = int( tablelookupbyrow( var0, var5, 1 ) );
            var8 = [];
            var9 = 7;
            
            for ( var10 = 2; var10 < var9 ; var10++ )
            {
                var6 = tablelookupbyrow( var0, var5, var10 );
                
                if ( !isdefined( var6 ) || var6 == "" )
                {
                    continue;
                }
                
                var8 = tablelookupbyrow( var0, var5, var10 );
            }
            
            var7.ref_12a7f = var8;
            var2.entries[ var2.entries.size ] = var7;
        }
        else
        {
            continue;
        }
        
        var3 = var6;
    }
    
    return var1;
}

// Params 0
// Size: 0x11
function tr_entergulag()
{
    return randomint( getdvarint( "scr_br_armory_trader_randomizer", 32767 ) );
}

// Params 0
// Size: 0x89
function onprematchdone()
{
    foreach ( var1 in level.debug_trap_room.scriptables )
    {
        var1 setscriptablepartstate( "br_armory_trader", "visible" );
        var1.visible = 1;
        var1.ref_13c6b = "default";
        var1.forceextractscriptable = tr_entergulag();
        var1.ref_11b72 = int( pow( 2, 4 ) ) - 1;
        toma_strike_trace_offset( var1 );
        initdropgrid( var1 );
        thread x1ops7();
    }
}

// Params 0
// Size: 0x3e
function toma_strike_trace_offset()
{
    var0 = spawn( "trigger_radius", self.origin, 0, 500, 500 );
    var0.playersintrigger = [];
    thread ref_14500( var0 );
    thread ref_14501( var0 );
    thread ref_14369();
    self.ref_1292c = var0;
}

// Params 1
// Size: 0x64
function ref_14500( var0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    
    for ( ;; )
    {
        self waittill( "trigger", var1 );
        
        if ( !isplayer( var1 ) )
        {
            continue;
        }
        
        if ( !var1 scripts\cp_mp\utility\player_utility::_isalive() )
        {
            continue;
        }
        
        var2 = var1 getentitynumber();
        
        if ( isdefined( self.playersintrigger[ var2 ] ) )
        {
            continue;
        }
        
        self.playersintrigger[ var2 ] = var1;
        thread ref_12027( var1, self );
    }
}

// Params 1
// Size: 0x68
function ref_14501( var0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    
    for ( ;; )
    {
        foreach ( var2 in self.playersintrigger )
        {
            if ( isdefined( var2 ) && var2 scripts\cp_mp\utility\player_utility::_isalive() && var2 istouching( self ) )
            {
                continue;
            }
            
            self.playersintrigger[ var3 ] = undefined;
            ref_12030( var2, var0 );
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0x16
function ref_14369()
{
    self endon( "death" );
    level waittill( "game_ended" );
    lb_mg_impulse_dmg_threshold_top();
}

// Params 0
// Size: 0x7
function lb_mg_impulse_dmg_threshold_top()
{
    self delete();
}

// Params 2
// Size: 0xc
function ref_12027( var0, var1 )
{
    thread monitorweaponchange( var1 );
}

// Params 2
// Size: 0x1e
function ref_12030( var0, var1 )
{
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    var0 notify( "weapon_trader_trigger_exited_" + var1.ref_1292c getentitynumber() );
}

// Params 1
// Size: 0x67
function monitorweaponchange( var0 )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "weapon_trader_trigger_exited_" + var0.ref_1292c getentitynumber() );
    var1 = scripts\mp\gametypes\br_weapons::router_use_obj();
    
    for ( ;; )
    {
        if ( !isdefined( var1 ) || var1.basename != "ks_use_crate_mp" && var1.basename != "none" )
        {
            ref_1400e( var0, self, var1 );
        }
        
        self waittill( "weapon_change", var1 );
        waitframe();
    }
}

// Params 0
// Size: 0x36
function x1ops7()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disabled" );
    
    for ( ;; )
    {
        level scripts\engine\utility::ref_143a5( "public_event_firesale_start", "public_event_firesale_end" );
        self.playcrateimpactfx = [];
        ref_1400d();
    }
}

// Params 0
// Size: 0x80
function ref_1400d()
{
    if ( isdefined( self.ref_1292c ) && isdefined( self.ref_1292c.playersintrigger ) )
    {
        foreach ( var1 in self.ref_1292c.playersintrigger )
        {
            var2 = var1.lastdroppableweaponobj;
            
            if ( !isdefined( var2 ) || var2.basename != "ks_use_crate_mp" && var2.basename != "none" )
            {
                ref_1400e( var1, var2 );
            }
        }
        
        return;
    }
}

// Params 2
// Size: 0x74
function dangercircletick( var0, var1 )
{
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "trader" ) || getdvarint( "scr_br_trader_ignore_circle", 0 ) == 1 )
    {
        return;
    }
    
    var2 = var1 * var1;
    
    foreach ( var4 in level.debug_trap_room.scriptables )
    {
        if ( isdefined( var4.visible ) && distance2dsquared( var4.origin, var0 ) > var2 )
        {
            little_bird_mg_mp_ondeathrespawncallback( var4 );
        }
    }
}

// Params 0
// Size: 0x4d
function little_bird_mg_initspawning()
{
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "trader" ) )
    {
        return;
    }
    
    foreach ( var1 in level.debug_trap_room.scriptables )
    {
        if ( isdefined( var1.visible ) )
        {
            little_bird_mg_mp_ondeathrespawncallback( var1 );
        }
    }
}

// Params 1
// Size: 0x54
function little_bird_mg_mp_ondeathrespawncallback( var0 )
{
    var0 setscriptablepartstate( "br_armory_trader", "disabled" );
    var0.visible = undefined;
    var0.disabled = 1;
    
    if ( var0 scripts\mp\gametypes\br_quest_util::gethelispawns() )
    {
        var0 scripts\mp\gametypes\br_quest_util::lastdropedtime();
    }
    
    if ( isdefined( var0.ref_1292c ) )
    {
        lb_mg_impulse_dmg_threshold_top( var0.ref_1292c );
    }
    
    var0 notify( "disabled" );
}

// Params 0
// Size: 0x2b
function registeraccesscardlocs()
{
    if ( !level.debug_trap_toggle )
    {
        return;
    }
    
    if ( istrue( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "placedTraders" ) ) )
    {
        return;
    }
    
    var0 = getentitylessscriptablearrayinradius( "scriptable_br_armory_trader", "classname" );
    return var0;
}

// Params 1
// Size: 0x11
function ref_131c0( var0 )
{
    level.debug_trap_room.scriptables = var0;
}

// Params 2
// Size: 0x2c
function run_module_pause_funcs( var0, var1 )
{
    var2 = var0;
    
    if ( updatecollectionuiforplayer( var1 ) )
    {
        var2 = 11;
    }
    else if ( var0 == 5 || var0 == 6 )
    {
        var2 = 4;
    }
    
    return var2;
}

// Params 2
// Size: 0x170
function ref_1400e( var0, var1 )
{
    var2 = undefined;
    var3 = 0;
    var4 = 0;
    
    if ( vars_print( var0, var1 ) )
    {
        var5 = restore_ai_weapon( var0, var1 );
        var2 = var5[ 0 ];
        var3 = var5[ 1 ];
        var4 = var5[ 2 ];
        var5 = undefined;
    }
    
    if ( !isdefined( var2 ) )
    {
        var6 = ref_13ffe( 0, undefined, 0, 4 );
        var0 setclientomnvar( "ui_br_weapon_trader_trade_data0", var6 );
        return;
    }
    
    var7 = run_module_pause_funcs( var3, var1 );
    var8 = [];
    
    for ( var9 = 0; var9 < 2 ; var9++ )
    {
        var8 = -1;
    }
    
    if ( !istrue( var1.van_blocker_moves ) )
    {
        var10 = 134217728;
        var10 = ~var10;
        var8 = var8[ 1 ] & var10;
    }
    
    var11 = 0;
    var8 = ref_13ffe( var8[ var11 ], var7, 0, 4 );
    var12 = run_maze_ai_common_function_stealth( var1, level.debug_trap_room.ref_13c65[ self.ref_13c6b ], var7 );
    
    if ( isdefined( var12 ) )
    {
        var13 = 4;
        var8 = ref_13ffe( var8[ var11 ], var4, var13, 4 );
        var13 += 4;
        var8 = ref_13ffe( var8[ var11 ], var6, var13, 4 );
        var13 += 4;
        
        foreach ( var15 in var12 )
        {
            var16 = removenonvipteamlocations( var15 );
            var8 = ref_13ffe( var8[ var11 ], var16, var13, 9 );
            var13 += 9;
            
            if ( var13 + 9 >= 32 )
            {
                var13 = 0;
                var11++;
            }
        }
    }
    
    for ( var9 = 0; var9 < var8.size ; var9++ )
    {
        var1 setclientomnvar( "ui_br_weapon_trader_trade_data" + var9, var8[ var9 ] );
    }
}

// Params 1
// Size: 0x1d, Type: bool
function updatecollectionuiforplayer( var0 )
{
    if ( !scripts\mp\gametypes\br_publicevents::upload_station_interact_used_think( 2 ) )
    {
        return false;
    }
    
    return !scripts\engine\utility::array_contains( self.playcrateimpactfx, var0 );
}

// Params 1
// Size: 0x12
function removenonvipteamlocations( var0 )
{
    return level.br_pickups.br_itemrow[ var0 ];
}

// Params 1
// Size: 0x36
function relic_vampire_feedback( var0 )
{
    if ( isdefined( var0 ) && isdefined( level.br_lootiteminfo[ var0 ] ) && isdefined( level.br_lootiteminfo[ var0 ].playerstartbesttimeupdate ) )
    {
        return level.br_lootiteminfo[ var0 ].playerstartbesttimeupdate;
    }
    
    return undefined;
}

// Params 4
// Size: 0x46
function ref_13ffe( var0, var1, var2, var3 )
{
    if ( !isdefined( var1 ) )
    {
        var1 = int( pow( 2, var3 + 1 ) - 1 );
    }
    
    var4 = int( pow( 2, var3 ) ) - 1;
    var4 <<= var2;
    var5 = ~var4;
    var0 &= var5;
    var6 = var1 << var2;
    var0 |= var6;
    return var0;
}

// Params 3
// Size: 0x8c, Type: bool
function get_car_stop_struct( var0, var1, var2 )
{
    if ( !isdefined( var2 ) )
    {
        return false;
    }
    
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
    
    if ( istrue( var1 scripts\mp\gametypes\br_gametypes::ref_12e05( "playerSkipKioskUse", var0 ) ) )
    {
        return false;
    }
    
    if ( istrue( var1.iscarrying ) && !isdefined( var1.get_search_turret_target_player ) )
    {
        var1 scripts\mp\hud_message::showerrormessage( "MP/FIELD_UPGRADE_CANNOT_USE" );
        return false;
    }
    
    if ( !vars_print( var1, var2 ) )
    {
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0x4f, Type: bool
function vars_print( var0 )
{
    if ( !isdefined( var0 ) || !isdefined( var0.inventorytype ) || var0 != self getcurrentweapon() && var0 != self getcurrentprimaryweapon() )
    {
        return false;
    }
    
    if ( var0.inventorytype != "primary" && var0.inventorytype != "altmode" )
    {
        return false;
    }
    
    return true;
}

// Params 5
// Size: 0x13d
function camera_loadout_showcase_preview_large_sticker_alt1( var0, var1, var2, var3, var4 )
{
    var5 = var3 scripts\mp\gametypes\br_weapons::router_use_obj();
    
    if ( !get_car_stop_struct( var0, var3, var5 ) )
    {
        return;
    }
    
    var6 = restore_ai_weapon( var3, var5 );
    var7 = var6[ 0 ];
    var8 = var6[ 1 ];
    var9 = var6[ 2 ];
    var6 = undefined;
    
    if ( !isdefined( var7 ) )
    {
        return;
    }
    
    var0 notify( "trader_use_start" );
    thread ref_13c6c();
    
    if ( var2 == "visible" )
    {
        var0 setscriptablepartstate( "br_armory_trader", "opening" );
        thread ref_13c66();
    }
    
    if ( istrue( var3.tracking_max_health ) )
    {
        var3 notify( "br_try_armor_cancel" );
    }
    
    var10 = run_module_pause_funcs( var0, var7, var3 );
    var3.camera_character_preview_select_detail = spawnstruct();
    var3.camera_character_preview_select_detail.curprogress = 0;
    var3.camera_character_preview_select_detail.usetime = run_to_retreat_spot( var0, var3, var10 );
    var3.camera_character_preview_select_detail.ref_14099 = rooftop_crate_usefunc( var0, var3, var10 );
    var3.camera_character_preview_select_detail.ref_145a2 = var5;
    ref_1387e( var3, var0, var5 );
    var11 = ref_1448c( var3, var0 );
    
    if ( isdefined( var3 ) )
    {
        ref_138f4( var3, var0, var11 );
    }
    
    if ( istrue( var11 ) )
    {
        var3 scripts\cp\vehicles\vehicle_compass_cp::ref_120a8( "trader" );
        thread advance_bomb_wire_list( var3, var0, var5, var7 );
    }
    
    var3.camera_character_preview_select_detail = undefined;
}

// Params 0
// Size: 0x68
function ref_13c6c()
{
    self endon( "trader_use_start" );
    level endon( "game_ended" );
    
    for ( var0 = 0; var0 < 30 ; var0 = 0 )
    {
        wait 1.5;
        var0 += 1.5;
        var1 = scripts\mp\utility\player::getplayersinradius( self.origin, 175 );
        
        if ( var1.size > 0 )
        {
        }
    }
    
    self setscriptablepartstate( "br_armory_trader", "closing" );
    self.forceextractscriptable = tr_entergulag();
    ref_1400d();
    thread ref_13c67();
}

// Params 0
// Size: 0x39
function ref_13c67()
{
    self endon( "trader_use_start" );
    level endon( "game_ended" );
    
    for ( var0 = 1; var0 ; var0 = var1.size > 0 )
    {
        wait 2;
        var1 = scripts\mp\utility\player::getplayersinradius( self.origin, 1000 );
    }
    
    heatcounter();
}

// Params 0
// Size: 0x8e
function heatcounter()
{
    wait 2;
    var0 = getdvarfloat( "MLLSRQSRT", 128 ) + 16;
    var1 = canceljoins( undefined, undefined, self.origin, var0 );
    
    if ( getdvarint( "scr_armory_trader_use_drop_grid", 1 ) )
    {
        var1 = scripts\engine\utility::array_combine_unique( var1, getlootscriptablearraydropgridshape() );
    }
    
    if ( isdefined( var1 ) )
    {
        foreach ( var3 in var1 )
        {
            if ( !scripts\mp\gametypes\br_pickups::update_gamebattles_char_loc( var3, 0 ) )
            {
                continue;
            }
            
            if ( var3 getscriptableisreserved() && !isdefined( var3.embassy_main ) )
            {
                continue;
            }
            
            scripts\mp\gametypes\br_pickups::ref_11a21( var3 );
        }
        
        return;
    }
}

// Params 2
// Size: 0x116, Type: bool
function ref_1448c( var0, var1 )
{
    var0 endon( "disconnect" );
    level endon( "game_ended" );
    var1.id = "weapon_trade";
    var1.userate = scripts\engine\utility::ter_op( isdefined( var0.objectivescaler ), var0.objectivescaler, 1 );
    playusesound( var0, var0.camera_character_preview_select_detail.ref_14099 );
    
    while ( isdefined( var0 ) && var0 scripts\cp_mp\utility\player_utility::_isalive() && get_aitypes_and_weights_from_call_counter( var0, var1 ) && var0 usebuttonpressed() )
    {
        var0.camera_character_preview_select_detail.curprogress += level.framedurationseconds * var1.userate;
        
        if ( var0.camera_character_preview_select_detail.curprogress >= var0.camera_character_preview_select_detail.usetime )
        {
            var0.camera_character_preview_select_detail.curprogress = 0;
            return true;
        }
        
        var0 scripts\mp\gameobjects::updateuiprogress( var1, 1, var0.camera_character_preview_select_detail );
        waitframe();
    }
    
    if ( isdefined( var0.camera_character_preview_select_detail ) && isdefined( var0.camera_character_preview_select_detail.curprogress ) )
    {
        var0.camera_character_preview_select_detail.curprogress = 0;
    }
    
    return false;
}

// Params 2
// Size: 0x8a, Type: bool
function get_aitypes_and_weights_from_call_counter( var0, var1 )
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
    
    if ( !isdefined( var0.camera_character_preview_select_detail ) || !var0 hasweapon( var0.camera_character_preview_select_detail.ref_145a2 ) )
    {
        return false;
    }
    
    var2 = getdvarfloat( "MLLSRQSRT", 128 ) + 16;
    var3 = var2 * var2;
    
    if ( distancesquared( var0.origin, var1.origin ) > var3 )
    {
        return false;
    }
    
    return true;
}

// Params 3
// Size: 0x43
function ref_1387e( var0, var1, var2 )
{
    thread camera_loadout_showcase_preview_charm_alt4( var0 );
    var0 scripts\mp\playeractions::allowactionset( "crateUse", 0 );
    var0 scripts\mp\gameobjects::updateuiprogress( var1, 0, var0.camera_character_preview_select_detail );
    var0 setclientomnvarbit( "ui_br_weapon_trader_trade_data1", 27, 1 );
    var0.van_blocker_moves = 1;
}

// Params 3
// Size: 0x60
function ref_138f4( var0, var1, var2 )
{
    var0 scripts\mp\playeractions::allowactionset( "crateUse", 1 );
    
    if ( isdefined( var0.camera_character_preview_select_detail ) )
    {
        var0 scripts\mp\gameobjects::updateuiprogress( var1, 0, var0.camera_character_preview_select_detail );
        stopusesound( var0, var0.camera_character_preview_select_detail.ref_14099 );
    }
    
    var0 setclientomnvarbit( "ui_br_weapon_trader_trade_data1", 27, 0 );
    var0 notify( "trader_use_end", var2 );
    var0.van_blocker_moves = undefined;
}

// Params 2
// Size: 0xb
function playusesound( var0, var1 )
{
    var0 playlocalsound( var1 );
}

// Params 2
// Size: 0x1f
function stopusesound( var0, var1 )
{
    var0 stoplocalsound( var1 );
    
    if ( var0 scripts\cp_mp\utility\player_utility::_isalive() )
    {
        var0 playsoundonmovingent( "WTS_gear_spurts_out" );
        return;
    }
}

// Params 1
// Size: 0x36
function camera_loadout_showcase_preview_charm_alt4( var0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    scripts\cp_mp\utility\weapon_utility::ref_12eb2();
    var1 = getcompleteweaponname( "ks_use_crate_mp" );
    scripts\cp_mp\utility\inventory_utility::_giveweapon( var1 );
    thread camera_loadout_showcase_preview_large_sticker( var1, var0 );
    self switchtoweapon( var1 );
}

// Params 2
// Size: 0x5a
function camera_loadout_showcase_preview_large_sticker( var0, var1 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self waittill( "trader_use_end", var2 );
    
    if ( scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring( var0 ) )
    {
        scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch( var0 );
        return;
    }
    
    scripts\cp_mp\utility\inventory_utility::_takeweapon( var0 );
    
    if ( !istrue( var2 ) && isdefined( var1 ) )
    {
        var3 = scripts\cp_mp\utility\weapon_utility::ref_12cc7( var1 );
        self switchtoweapon( var3 );
        thread scripts\cp_mp\utility\inventory_utility::forcevalidweapon( var3 );
        return;
    }
}

// Params 0
// Size: 0x24
function ref_13c66()
{
    if ( !getdvarint( "scr_br_trader_fix_prone_players", 1 ) )
    {
        return;
    }
    
    var0 = getdvarfloat( "scr_br_trader_fix_prone_players_radius", 300 );
    scripts\mp\gametypes\br_functional_poi::player_give_intel_1_ks( var0 );
}

// Params 4
// Size: 0xf6
function advance_bomb_wire_list( var0, var1, var2, var3 )
{
    if ( !isdefined( var2 ) || !isdefined( var3 ) )
    {
        return;
    }
    
    ref_121e6( var2 );
    
    if ( var3 == 11 )
    {
        var0.playcrateimpactfx = scripts\engine\utility::array_add( var0.playcrateimpactfx, self );
    }
    
    self takeweapon( var1 );
    
    if ( !self hasweapon( "iw8_fists_mp" ) )
    {
        self giveweapon( "iw8_fists_mp" );
    }
    
    self switchtoweapon( "iw8_fists_mp" );
    var4 = ref_13657( var0, self, level.debug_trap_room.ref_13c65[ var0.ref_13c6b ], var3 );
    
    if ( level.debug_trap_toggle && !scripts\mp\gametypes\br_public::turret_headicon() )
    {
        thread scripts\mp\utility\points::giveunifiedpoints( "br_armory_trader_use", undefined, safehouse_spawn( var2 ) );
    }
    
    if ( !isdefined( var4 ) )
    {
        var4 = [];
    }
    
    var5 = 0;
    
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) )
    {
        var5 = level.br_circle.circleindex;
    }
    
    self dlog_recordplayerevent( "dlog_event_armory_trade", [ "weapon_rarity", var2, "trade_rarity", var3, "circle_index", var5, "received_items", var4 ] );
}

// Params 2
// Size: 0x5a
function run_to_retreat_spot( var0, var1 )
{
    if ( !isdefined( var1 ) )
    {
        return getdvarfloat( "scr_br_trader_use_time_0", level.debug_trap_room.ref_140a2[ 0 ] );
    }
    else if ( var1 == 11 )
    {
        return getdvarfloat( "scr_br_trader_firesale_use_time", 3 );
    }
    
    var1 = int( clamp( var1, 0, 4 ) );
    return getdvarfloat( "scr_br_trader_use_time_" + var1, level.debug_trap_room.ref_140a2[ var1 ] );
}

// Params 2
// Size: 0x3b
function rooftop_crate_usefunc( var0, var1 )
{
    if ( !isdefined( var1 ) )
    {
        return "WTS_rarity_common";
    }
    else if ( var1 == 11 )
    {
        return "WTS_rarity_firesale";
    }
    
    var1 = int( clamp( var1, 0, 4 ) );
    return level.debug_trap_room.ref_1409a[ var1 ];
}

// Params 1
// Size: 0x33
function safehouse_spawn( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return 0;
    }
    else if ( var0 == 11 )
    {
        return 100;
    }
    
    var0 = int( clamp( var0, 0, 4 ) );
    return level.debug_trap_room.xp[ var0 ];
}

// Params 1
// Size: 0xbc
function restore_ai_weapon( var0 )
{
    var1 = self;
    var2 = undefined;
    var3 = 0;
    var4 = 0;
    var5 = createheadicon( var0 getnoaltweapon() );
    
    if ( isdefined( level.br_pickups.br_weapontoscriptable[ var5 ] ) )
    {
        var6 = level.br_pickups.br_weapontoscriptable[ var5 ];
        
        if ( isdefined( var6 ) )
        {
            var2 = level.br_pickups.delay_hide_player_clip[ var6 ];
            var3 = original_health( var0 );
            var7 = scripts\mp\utility\weapon::relic_nuketimer_globalthread( var0.basename );
            var4 = removespecialistbonuspickup( var7 );
        }
    }
    else if ( scripts\mp\gametypes\br_weapons::vandalize_attack_max_cooldown( var0 ) )
    {
        var2 = restorekillstreakplayerangles( var5 );
        
        if ( !isdefined( var2 ) )
        {
            var3 = original_health( var0 );
            var7 = scripts\mp\utility\weapon::relic_nuketimer_globalthread( var0.basename );
            var4 = removespecialistbonuspickup( var7 );
            var2 = getcustomweaponrarity( var3, var4 );
        }
    }
    
    return [ var2, var3, var4 ];
}

// Params 2
// Size: 0x8e
function getcustomweaponrarity( var0, var1 )
{
    var2 = 0;
    
    if ( var0 == var1 )
    {
        var2 = 5;
    }
    else if ( var0 == 0 )
    {
        var2 = 0;
    }
    else if ( var1 == 0 )
    {
        var2 = 0;
    }
    else if ( var1 > 5 )
    {
        var3 = [ 3, 5, 6, 8, 10 ];
        
        for ( var4 = 0; var4 < var3.size ; var4++ )
        {
            if ( var0 <= var3[ var4 ] )
            {
                var2 = var4;
                break;
            }
        }
    }
    else
    {
        var5 = float( var0 - 1 ) / float( var1 );
        var2 = int( var5 / 0.2 );
    }
    
    return var2;
}

// Params 1
// Size: 0x3e
function restorekillstreakplayerangles( var0 )
{
    var1 = strtok( var0, "_" );
    
    if ( var1.size > 1 )
    {
        if ( var1[ 1 ] == "me" )
        {
            return 2;
        }
        else if ( var1[ 1 ] == "la" )
        {
            return 2;
        }
    }
    
    return undefined;
}

// Params 1
// Size: 0x40
function original_health( var0 )
{
    var1 = scripts\cp\vehicles\vehicle_compass_cp::runleadmarkers( var0 );
    var2 = 0;
    
    foreach ( var4 in var1 )
    {
        if ( var4 != "" )
        {
            var2++;
        }
    }
    
    return var2;
}

// Params 1
// Size: 0x30
function removespecialistbonuspickup( var0 )
{
    var1 = tablelookup( "mp/statstable.csv", 5, var0, 18 );
    
    if ( isdefined( var1 ) && var1 != "" )
    {
        var1 = int( var1 );
    }
    else
    {
        var1 = 0;
    }
    
    return var1;
}

// Params 2
// Size: 0x29
function ref_13c68( var0, var1 )
{
    var2 = self.forceextractscriptable;
    
    if ( var1 != 0 )
    {
        var2 = scripts\engine\utility::ter_op( var2 > self.ref_11b72, var2 >> var1, var2 << var1 );
    }
    
    return var2 % var0;
}

// Params 2
// Size: 0x83
function ref_13c69( var0, var1 )
{
    var2 = 0;
    
    foreach ( var4 in var0 )
    {
        var2 += var4.weight;
    }
    
    if ( var2 == 0 )
    {
        return undefined;
    }
    
    var6 = ref_13c68( var2, var1 );
    var7 = 0;
    
    foreach ( var4 in var0 )
    {
        var7 += var4.weight;
        
        if ( var7 >= var6 )
        {
            return var4.ref_12a7f;
        }
    }
    
    return undefined;
}

// Params 3
// Size: 0x39
function run_maze_ai_common_function_stealth( var0, var1, var2 )
{
    if ( !isdefined( var1 ) )
    {
        return undefined;
    }
    
    var3 = run_lbravos_safehouse( var2, var1 );
    var4 = var1[ var3 ];
    var5 = ref_13c69( var4.entries, 0 );
    var5 = vehicle_collision_update( var5, var2 );
    return scripts\engine\utility::array_removeundefined( var5 );
}

// Params 1
// Size: 0x14
function registerbrgametypefunc( var0 )
{
    var1 = scripts\mp\utility\weapon::getweapongroup( var0 );
    return scripts\mp\gametypes\br_weapons::debug_spawning( var1, var0 );
}

// Params 2
// Size: 0x64
function battle_tracks_onentervehicle( var0, var1 )
{
    if ( var1 > 0 )
    {
        foreach ( var3 in var0 )
        {
            if ( isdefined( level.br_lootiteminfo[ var3 ] ) && isdefined( level.br_lootiteminfo[ var3 ].baseweapon ) )
            {
                var0 = registerbrgametypefunc( level.br_lootiteminfo[ var3 ].baseweapon );
            }
        }
    }
    
    return var0;
}

// Params 2
// Size: 0x23
function dialog_play_shieldstow( var0, var1 )
{
    if ( scripts\mp\gametypes\br_weapons::trial_vehicle( var0 ) )
    {
        var2 = getdvarint( "scr_br_armory_trader_received_ammo_stack_count", 2 );
        var1 *= var2;
    }
    
    return var1;
}

// Params 3
// Size: 0xab
function ref_13657( var0, var1, var2 )
{
    var3 = run_maze_ai_common_function_stealth( var0, var1, var2 );
    
    if ( !isdefined( var3 ) || var3.size == 0 )
    {
        return var3;
    }
    
    var3 = battle_tracks_onentervehicle( var3, var2 );
    var4 = spawnstruct();
    var5 = anglestoforward( ( 0, self.angles[ 1 ], 0 ) );
    var4.origin = self.origin + var5 * 25;
    var4.angles = ( 0, self.angles[ 1 ], 0 );
    var4.itemsdropped = 0;
    var4.intro_ride = &dialog_reachnextcheckpoint;
    var4.intro_moveplayercliphack = &dialog_play_shieldstow;
    var4.ref_13a77 = var0;
    var4.intro_heli_add_player = 60;
    var4.„`\	³Gý = self;
    var6 = var4 scripts\mp\gametypes\br_lootcache::ref_11a42( var3, 0, undefined );
    return var3;
}

// Params 2
// Size: 0x7e
function lootspawndefault( var0, var1 )
{
    var2 = [ 0, 50, -50, 25, -25, 80, -80 ];
    var3 = self.ref_13a77.origin - var0;
    var4 = max( length2d( var3 ) - 15, 30 );
    var5 = vectorcross( var3, ( 0, 0, 1 ) );
    var5 = vectornormalize( var5 );
    var6 = randomfloatrange( -5, 5 );
    var7 = var2[ var1.ml_p3_to_safehouse_transition % var2.size ] + var6;
    var8 = var5 * var7;
    var8 = var0 + var3 + var8;
    return [ var8, var6, var4 ];
}

// Params 2
// Size: 0x11f
function lootspawndropgrid( var0, var1 )
{
    var2 = 32.5;
    var3 = 360 / var1.—%…°!´ºpYçoˆZ¹ * var1.ml_p3_to_safehouse_transition;
    var4 = vectornormalize( self.ref_13a77.origin - var0 );
    var4 *= var2;
    var4 += var0;
    self.´Ç	IKr¿°âÌ = sortpointsbydistance( self.„`\	³Gý.´Ç	IKr¿°âÌ, var4 );
    var5 = undefined;
    
    foreach ( var7 in self.´Ç	IKr¿°âÌ )
    {
        var8 = canceljoins( undefined, undefined, var7, var2 );
        
        if ( isdefined( var8 ) && var8.size == 0 )
        {
            var9 = scripts\mp\utility\player::getplayersinradius( var7, var2 );
            
            if ( var9.size == 0 || var9.size == 1 && var9[ 0 ] == self.ref_13a77 )
            {
                var5 = var7;
                break;
            }
        }
    }
    
    var5 = undefined;
    var8 = undefined;
    
    if ( !isdefined( var4 ) )
    {
        var4 = self.´Ç	IKr¿°âÌ[ 0 ];
    }
    
    if ( var0.—%…°!´ºpYçoˆZ¹ > 1 )
    {
        var11 = randomfloatrange( -15, 15 );
        var4 += rotatevector( ( -20, 0, 0 ), ( 0, var2 + var11, 0 ) );
    }
    
    var12 = var4 - <error>;
    var13 = max( length2d( var12 ), 30 );
    return [ var4, 0, var13 ];
}

// Params 8
// Size: 0xb5
function dialog_reachnextcheckpoint( var0, var1, var2, var3, var4, var5, var6, var7 )
{
    jumpiffalse(getdvarint( "scr_armory_trader_use_drop_grid", 1 )) LOC_00000040;
    var8 = lootspawndropgrid( var2, var1 );
    var9 = var8[ 0 ];
    var10 = var8[ 1 ];
    var11 = var8[ 2 ];
    var8 = undefined;
    goto LOC_00000064;
}

// Params 2
// Size: 0x8a
function sortpointsbydistance( var0, var1 )
{
    var2 = [];
    
    foreach ( var4 in var0 )
    {
        var5 = spawnstruct();
        var5.point = var4;
        var5.loot_choppers = distancesquared( var4, var1 );
        var2 = var5;
    }
    
    var2 = scripts\mp\utility\script::quicksort( var2, &comparepointdistance );
    var7 = [];
    
    foreach ( var9 in var2 )
    {
        var7 = var9.point;
    }
    
    return var7;
}

// Params 2
// Size: 0x15, Type: bool
function comparepointdistance( var0, var1 )
{
    return var0.loot_choppers <= var1.loot_choppers;
}

// Params 0
// Size: 0xac
function initdropgrid()
{
    var0 = 32.5;
    var1 = [];
    var2 = anglestoforward( self.angles );
    var3 = anglestoright( self.angles );
    
    for ( var4 = -3; var4 < 3 ; var4++ )
    {
        for ( var5 = 0; var5 < 3 ; var5++ )
        {
            var6 = var5 * 65 + var0 + 30;
            var7 = var4 * 65 + var0;
            var8 = self.origin + var6 * var2 + var7 * var3;
            
            if ( scripts\engine\trace::ray_trace_passed( self.origin + ( 0, 0, 20 ), var8 + ( 0, 0, 20 ) ) )
            {
                var1 = var8;
            }
        }
    }
    
    self.´Ç	IKr¿°âÌ = var1;
}

// Params 0
// Size: 0x48
function getdropgridshape()
{
    var0 = anglestoforward( self.angles );
    var1 = anglestoright( self.angles );
    var2 = var0 * 225;
    var3 = var1 * 195;
    var4 = self.origin - var3;
    var5 = var4 + var2;
    var6 = self.origin + var3;
    var7 = var6 + var2;
    return [ var4, var5, var7, var6 ];
}

// Params 2
// Size: 0x34, Type: bool
function isinsidedropgridshape( var0, var1 )
{
    for ( var2 = 0; var2 < var1.size ; var2++ )
    {
        var3 = ( var2 + 1 ) % var1.size;
        
        if ( !use_nvg_think( var0, var1[ var2 ], var1[ var3 ] ) )
        {
            return false;
        }
    }
    
    return true;
}

// Params 3
// Size: 0x2c, Type: bool
function use_nvg_think( var0, var1, var2 )
{
    return ( var2[ 0 ] - var1[ 0 ] ) * ( var0[ 1 ] - var1[ 1 ] ) - ( var0[ 0 ] - var1[ 0 ] ) * ( var2[ 1 ] - var1[ 1 ] ) < 0;
}

// Params 0
// Size: 0x80
function getlootscriptablearraydropgridshape()
{
    var0 = getdropgridshape();
    var1 = var0[ 1 ];
    var2 = distance( var1, self.origin );
    var3 = canceljoins( undefined, undefined, self.origin, var2 );
    var4 = [];
    
    foreach ( var6 in var3 )
    {
        if ( abs( var6.origin[ 2 ] - self.origin[ 2 ] ) < 30 && isinsidedropgridshape( var6.origin, var0 ) )
        {
            var4 = var6;
        }
    }
    
    return var4;
}

// Params 2
// Size: 0x93
function run_lbravos_safehouse( var0, var1 )
{
    var2 = undefined;
    
    foreach ( var4 in var1 )
    {
        foreach ( var6 in var4.ref_13a31 )
        {
            var7 = risktokenstokeep( var6 );
            var8 = isint( var7 ) && isint( var0 );
            var8 |= isstring( var7 ) && isstring( var0 );
            
            if ( var8 && var7 == var0 )
            {
                var2 = var10;
            }
        }
    }
    
    return var2;
}

// Params 1
// Size: 0x34
function risktokenstokeep( var0 )
{
    var1 = undefined;
    var2 = strtok( var0, "_" );
    
    if ( var2.size == 1 )
    {
        var1 = var2;
    }
    else if ( var2.size == 2 )
    {
        var1 = int( var2[ 0 ] );
    }
    
    return var1;
}

// Params 1
// Size: 0x3d, Type: bool
function get_bombzone_node_to_plant_on( var0 )
{
    return !level.br_pickups.delay_give_lethal_grenade[ var0 ] && !scripts\engine\utility::array_contains( level.debug_trap_room.ref_11a20, var0 ) && !scripts\engine\utility::array_contains( level.debug_trap_room.play_lighting_sequence, var0 );
}

// Params 1
// Size: 0x75
function ref_12e83( var0 )
{
    var1 = [];
    
    foreach ( var3 in var0 )
    {
        var4 = 1;
        
        if ( isdefined( level.br_lootiteminfo[ var3 ] ) )
        {
            var5 = weaponclass( level.br_lootiteminfo[ var3 ].playerstartjailsetcontrols );
            var4 = !isdefined( var5 ) || var5 != "pistol";
        }
        
        if ( var4 && get_bombzone_node_to_plant_on( var3 ) )
        {
            var1 = scripts\engine\utility::array_add( var1, var3 );
        }
    }
    
    return var1;
}

// Params 1
// Size: 0x37
function ref_12e84( var0 )
{
    var1 = [];
    
    foreach ( var3 in var0 )
    {
        if ( get_bombzone_node_to_plant_on( var4 ) )
        {
            var1 = var3;
        }
    }
    
    return var1;
}

// Params 2
// Size: 0x41
function play_music_on_wave_reinforce( var0, var1 )
{
    var2 = [];
    
    foreach ( var4 in var0 )
    {
        if ( level.br_pickups.delay_hide_player_clip[ var5 ] == var1 )
        {
            var2 = var4;
        }
    }
    
    return var2;
}

// Params 2
// Size: 0x43
function filterpickupitembyrarity_intindexed( var0, var1 )
{
    var2 = [];
    
    foreach ( var4 in var0 )
    {
        if ( level.br_pickups.delay_hide_player_clip[ var4 ] == var1 )
        {
            var2 = var4;
        }
    }
    
    return var2;
}

// Params 2
// Size: 0x214
function vehicle_collision_update( var0, var1 )
{
    var2 = [];
    
    foreach ( var4 in var0 )
    {
        if ( isdefined( level.br_pickups.br_itemtype[ var4 ] ) )
        {
            if ( getdvarint( "scr_br_armory_trader_allow_plunder", 1 ) == 0 && isstartstr( var4, "brloot_plunder_cash_" ) )
            {
                continue;
            }
            
            if ( get_bombzone_node_to_plant_on( var4 ) )
            {
                var2 = var4;
            }
            
            continue;
        }
        
        var5 = strtok( var4, "_" );
        var6 = int( var5[ 0 ] );
        
        if ( var5.size > 1 && isnumber( var6 ) )
        {
            if ( var5[ 1 ] == "weapon" )
            {
                var7 = ref_12e83( level.br_pickups.delay_safe_spawn_chopper_boss[ var6 ] );
                var2 = risk_flagspawnminactivetospawn( var7, var1 );
            }
            else if ( var5[ 1 ] == "super" )
            {
                var7 = ref_12e84( level.br_pickups.br_superreference );
                var7 = play_music_on_wave_reinforce( var7, var6 );
                var2 = risk_flagspawnmincount( var7, var1 );
                
                if ( !istrue( level.debug_trap_room.¸éžõ%Ú¾¹ðs'XóxÒÓ¢•g»£ê@P ) && getdvarint( "scr_advancedSupplyDropErrorCheck", 1 ) )
                {
                    doadvancedsupplydroperrorcheck( var7, var2 );
                }
            }
            else if ( var5[ 1 ] == "killstreak" )
            {
                var7 = ref_12e84( level.br_pickups.br_killstreakreference );
                var7 = ref_12c29( var7 );
                var7 = play_music_on_wave_reinforce( var7, var6 );
                var2 = risk_flagspawnmincount( var7, var1 );
            }
            else if ( var5[ 1 ] == "perkpoint" )
            {
                var7 = ref_12e83( level.br_pickups.br_perkpoints );
                var7 = filterpickupitembyrarity_intindexed( var7, var6 );
                var2 = risk_flagspawnminactivetospawn( var7, var1 );
            }
        }
        else if ( var5[ 0 ] == "lethal" )
        {
            var7 = ref_12e83( level.br_pickups.delay_push_player_clear_door_way );
            var2 = risk_flagspawnminactivetospawn( var7, var1 );
        }
        else if ( var5[ 0 ] == "tactical" )
        {
            var7 = ref_12e83( level.br_pickups.deletesoundents );
            var2 = risk_flagspawnminactivetospawn( var7, var1 );
        }
    }
    
    return var2;
}

// Params 2
// Size: 0xb8
function doadvancedsupplydroperrorcheck( var0, var1 )
{
    var2 = undefined;
    
    foreach ( var4 in var0 )
    {
        if ( var4 == "super_supply_drop" || var4 == "brloot_offhand_advancedsupplydrop" )
        {
            var2 = "br_armory_trader can give a super_supply_drop which shouldn't. FilterItem size : " + level.debug_trap_room.play_lighting_sequence.size + "   item: " + var4;
            break;
        }
    }
    
    var6 = var1[ var1.size - 1 ];
    
    if ( var6 == "super_supply_drop" || var6 == "brloot_offhand_advancedsupplydrop" )
    {
        if ( !isdefined( var2 ) )
        {
            var2 = "";
        }
        
        var2 += " br_armory_trader is giving " + var6 + " which shouldn't.";
    }
    
    if ( isdefined( var2 ) )
    {
        level.debug_trap_room.¸éžõ%Ú¾¹ðs'XóxÒÓ¢•g»£ê@P = 1;
        logtraderfilter();
        scripts\mp\utility\script::laststand_dogtags( var2 );
        return;
    }
}

// Params 1
// Size: 0x38
function ref_12c29( var0 )
{
    var1 = [];
    
    foreach ( var3 in var0 )
    {
        if ( var4 != "brloot_specialist_bonus" )
        {
            var1 = var3;
        }
    }
    
    return var1;
}

// Params 2
// Size: 0x27
function risk_flagspawnminactivetospawn( var0, var1 )
{
    var2 = undefined;
    
    if ( isdefined( var0 ) && var0.size > 0 )
    {
        var3 = ref_13c68( var0.size, var1 );
        var2 = var0[ var3 ];
    }
    
    return var2;
}

// Params 2
// Size: 0x57
function risk_flagspawnmincount( var0, var1 )
{
    var2 = undefined;
    
    if ( isdefined( var0 ) && var0.size > 0 )
    {
        var3 = ref_13c68( var0.size, var1 );
        var4 = 0;
        
        foreach ( var6 in var0 )
        {
            if ( var4 == var3 )
            {
                var2 = var7;
                break;
            }
            
            var4++;
        }
    }
    
    return var2;
}

// Params 1
// Size: 0x17
function ref_121e6( var0 )
{
    if ( var0 == 4 )
    {
        scripts\cp\vehicles\vehicle_compass_cp::ref_12004( "tw_leg" );
        return;
    }
}

