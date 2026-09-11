
// Params 0
// Size: 0xd9
function init()
{
    level.br_armory_kiosk = spawnstruct();
    level.br_armory_kiosk.scriptables = [];
    level.br_armory_kiosk_enabled = getdvarint( "scr_br_armory_kiosk", 1 ) != 0;
    level.delay_put_vehicles_on_compass = getdvarint( "scr_loadout_purchase_restricted", 0 );
    level.∂≠òNØ¬ì÷∑…Â◊[Z€õ÷˙±€ÊYæk≤Ê’ØôKá = getdvarint( "scr_br_armory_kiosk_close_menu_fix", 1 );
    level.ë#5Ç9‡ﬁW*õ‚1ÿJ„«Ø4ù®≠w"q˚ÔMeEﬂ¥ = getdvarfloat( "scr_br_armory_kiosk_close_menu_timeout", 0.5 );
    
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "kiosk" ) )
    {
        level.br_armory_kiosk_enabled = 0;
        return;
    }
    
    if ( level.br_armory_kiosk_enabled )
    {
        scripts\engine\scriptable::ref_12f5b( "br_plunder_box", &armorykioskused );
        scripts\engine\scriptable::ref_12f5b( "br_portable_kiosk", &armorykioskused );
        scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback( &onarmorykioskpurchase );
        allassassin_applyquest();
        _parsepurchaseitemtables();
        thread apc_shoot_at_target();
    }
    
    scripts\mp\gametypes\br_gametypes::ref_12b11( "getIdFromRefInPurchaseTable", &_getidfromref );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "getScriptedDiscountId", &callback_getscripteddiscountid );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "setScriptedDiscountId", &callback_setscripteddiscountid );
}

// Params 0
// Size: 0x78
function all_waves()
{
    if ( getdvar( "scr_br_gametype", "" ) == "dmz" || getdvar( "scr_br_gametype", "" ) == "rat_race" || getdvar( "scr_br_gametype", "" ) == "risk" || getdvar( "scr_br_gametype", "" ) == "gold_war" )
    {
        setdvar( "br_kiosk_ignored_tab_nums", "2,5" );
        return;
    }
    
    setdvar( "br_kiosk_ignored_tab_nums", "3,4,5" );
}

// Params 0
// Size: 0xc2
function allassassin_applyquest()
{
    var0 = getdvarint( "br_kiosk_sales_discount", 0 );
    level.br_armory_kiosk.ref_12e7b = int( clamp( var0, 0, 100 ) );
    var1 = getdvar( "br_kiosk_sales_discount_items", "" );
    level.br_armory_kiosk.ref_12e7c = strtok( var1, "," );
    var2 = 20;
    var3 = level.br_armory_kiosk.ref_12e7b % var2;
    
    if ( var3 > 0 )
    {
        var4 = int( floor( level.br_armory_kiosk.ref_12e7b / var2 ) * var2 );
        var5 = var3 / var2 >= 0.5;
        
        if ( var5 )
        {
            var4 += var2;
        }
        
        level.br_armory_kiosk.ref_12e7b = int( var4 );
    }
    
    if ( var0 != level.br_armory_kiosk.ref_12e7b )
    {
        setdvar( "br_kiosk_sales_discount", level.br_armory_kiosk.ref_12e7b );
        return;
    }
}

// Params 2
// Size: 0x3d
function add_collision_to_hack_point( var0, var1 )
{
    if ( !isdefined( var1 ) || var1 == 0 )
    {
        return var0;
    }
    else if ( var1 == 100 )
    {
        return 0;
    }
    
    var2 = ( 100 - var1 ) * 0.01;
    return int( ceil( var0 * var2 - 0.5 ) );
}

// Params 0
// Size: 0x3d8
function _parsepurchaseitemtables()
{
    var0 = getdvar( "br_kiosk_items_filename", "mp/brKioskPurchases.csv" );
    
    if ( var0 == "" )
    {
        var0 = "mp/brKioskPurchases.csv";
    }
    
    if ( getdvarint( "scr_br_alt_mode_ff", 0 ) == 1 )
    {
        if ( getdvarint( "scr_br_ff_buyback", 0 ) == 1 || getdvarint( "scr_br_ff_killstreaks", 0 ) == 1 )
        {
            level.dialog_wait_ready_civ = 7;
        }
    }
    
    level.br_armory_kiosk.items = [];
    var1 = tablelookupgetnumrows( var0 );
    
    for ( var2 = 0; var2 < var1 ; var2++ )
    {
        var3 = int( tablelookupbyrow( var0, var2, 0 ) );
        var4 = spawnstruct();
        var4.type = tablelookupbyrow( var0, var2, 1 );
        var4.ref = tablelookupbyrow( var0, var2, 2 );
        var4.cost = int( tablelookupbyrow( var0, var2, 3 ) );
        var4.playboxuseanimation = int( tablelookupbyrow( var0, var2, 9 ) );
        var4.ref_122fc = int( tablelookupbyrow( var0, var2, 10 ) );
        var4.õÿlK…6ÿV#-7∆Ω´7G = int( tablelookupbyrow( var0, var2, 12 ) );
        
        if ( var4.ref == "supply_drop" )
        {
            var5 = getdvarint( "scr_br_kiosk_supdropcost", 0 );
            
            if ( var5 != 0 )
            {
                var4.cost = var5;
            }
        }
        
        if ( var4.ref == "specialist_perk" )
        {
            var6 = getdvarint( "scr_br_kiosk_specialistcost", 500 );
            
            if ( var6 != 0 )
            {
                var4.cost = var6;
            }
        }
        
        if ( var4.ref == "vehicle_refill_trophy" )
        {
            var5 = getdvarint( "scr_br_kiosk_truckwar_refill_trophy_cost", 0 );
            
            if ( var5 != 0 )
            {
                var4.cost = var5;
            }
        }
        
        if ( var4.ref == "vehicle_repair" )
        {
            var5 = getdvarint( "scr_br_kiosk_truckwar_repair_cost", 0 );
            
            if ( var5 != 0 )
            {
                var4.cost = var5;
            }
        }
        
        if ( var4.ref == "vehicle_replace" )
        {
            var5 = getdvarint( "scr_br_kiosk_truckwar_replace_cost", 0 );
            
            if ( var5 != 0 )
            {
                var4.cost = var5;
            }
        }
        
        if ( var4.ref == "vehicle_upgrade_armor" )
        {
            var5 = getdvarint( "scr_br_kiosk_truckwar_armor_cost", 0 );
            
            if ( var5 != 0 )
            {
                var4.cost = var5;
            }
        }
        
        if ( var4.ref == "vehicle_upgrade_trophy" )
        {
            var5 = getdvarint( "scr_br_kiosk_truckwar_trophy_cost", 0 );
            
            if ( var5 != 0 )
            {
                var4.cost = var5;
            }
        }
        
        if ( var4.ref == "vehicle_upgrade_uav" )
        {
            var5 = getdvarint( "scr_br_kiosk_truckwar_uav_cost", 0 );
            
            if ( var5 != 0 )
            {
                var4.cost = var5;
            }
        }
        
        if ( var4.ref == "vehicle_upgrade_barrel" )
        {
            var5 = getdvarint( "scr_br_kiosk_truckwar_barrel_cost", 0 );
            
            if ( var5 != 0 )
            {
                var4.cost = var5;
            }
        }
        
        if ( level.br_armory_kiosk.ref_12e7b > 0 )
        {
            var7 = level.br_armory_kiosk.ref_12e7c.size == 0 || scripts\engine\utility::array_contains( level.br_armory_kiosk.ref_12e7c, var4.ref );
            
            if ( var7 )
            {
                var4.cost = add_collision_to_hack_point( var4.cost, level.br_armory_kiosk.ref_12e7b );
            }
        }
        
        if ( var4.type == "loadout_default" )
        {
            level.br_armory_kiosk.ref_11958 = var4.cost;
            level.br_armory_kiosk.ref_11959 = var4.playboxuseanimation;
            level.br_armory_kiosk.ref_1195a = var4.ref_122fc;
            continue;
        }
        
        if ( var4.type == "loadout_custom" )
        {
            level.br_armory_kiosk.ref_11955 = var4.cost;
            level.br_armory_kiosk.ref_11956 = var4.playboxuseanimation;
            level.br_armory_kiosk.ref_11957 = var4.ref_122fc;
            continue;
        }
        
        if ( var4.type == "teamrevive" )
        {
            level.br_armory_kiosk.ref_13ac2 = var4.cost;
            level.br_armory_kiosk.ref_13ac3 = var4.playboxuseanimation;
            level.br_armory_kiosk.ref_13ac4 = var4.ref_122fc;
            continue;
        }
        
        level.br_armory_kiosk.items[ var3 ] = var4;
    }
}

// Params 7
// Size: 0x96
function ai_push_to_position( var0, var1, var2, var3, var4, var5, var6 )
{
    var7 = [ scripts\engine\utility::ter_op( isdefined( var6 ), var6, 0 ), scripts\engine\utility::ter_op( var2, var3, 0 ), scripts\engine\utility::ter_op( var4, var5, 0 ) ];
    var8 = _getbestdiscount( var7 );
    var9 = add_collision_to_hack_point( var1, var8 );
    
    if ( isdefined( var0 ) && var0.ref == "supply_drop" && getdvarint( "br_use_circle_percent_discount", 0 ) == 1 )
    {
        var10 = getomnvar( "ui_br_circle_num" ) - 1;
        
        if ( var10 >= 1 )
        {
            var11 = var0.õÿlK…6ÿV#-7∆Ω´7G;
            
            if ( var11 > 0 )
            {
                var11 *= var10;
                var9 = add_collision_to_hack_point( var9, var11 );
            }
        }
    }
    
    return var9;
}

// Params 1
// Size: 0x33
function _getbestdiscount( var0 )
{
    var1 = 0;
    
    foreach ( var3 in var0 )
    {
        if ( var3 > var1 )
        {
            var1 = var3;
        }
    }
    
    return var1;
}

// Params 0
// Size: 0x9a
function apc_shoot_at_target()
{
    level endon( "game_ended" );
    setdvarifuninitialized( "scr_br_disable_kiosk_by_circle", 0 );
    
    for ( ;; )
    {
        level waittill( "br_circle_set" );
        var0 = getdvarint( "scr_br_disable_kiosk_by_circle", 0 );
        
        if ( var0 == 0 )
        {
            continue;
        }
        
        if ( level.br_circle.circleindex + 1 >= var0 )
        {
            little_bird_mg_initomnvars();
            
            foreach ( var2 in level.players )
            {
                if ( !isdefined( var2 ) || !isalive( var2 ) )
                {
                    continue;
                }
                
                var2 thread scripts\mp\hud_message::showsplash( "br_kiosks_disabled" );
            }
            
            break;
        }
    }
}

// Params 1
// Size: 0x84
function ref_1334a( var0 )
{
    var1 = self;
    var1 endon( "disconnect" );
    level endon( "game_ended" );
    
    if ( istrue( var1.shoulddopublicevent ) )
    {
        return;
    }
    
    if ( !isdefined( level.br_armory_kiosk.ref_12e7b ) )
    {
        return;
    }
    
    if ( level.br_armory_kiosk.ref_12e7b == 0 )
    {
        return;
    }
    
    var1.shoulddopublicevent = 1;
    
    if ( isdefined( var0 ) && var0 > 0 )
    {
        wait var0;
    }
    
    if ( level.br_armory_kiosk.ref_12e7c.size == 0 )
    {
        var1 thread scripts\mp\hud_message::showsplash( "br_sales_event_all" );
        return;
    }
    
    var1 thread scripts\mp\hud_message::showsplash( "br_sales_event_selective" );
}

// Params 0
// Size: 0x65
function onprematchdone()
{
    if ( level.delay_put_vehicles_on_compass )
    {
        ref_13169( "supply_drop", 1 );
        level.ref_12931 = "br_pe_loadout_drop_start";
    }
    
    foreach ( var1 in level.br_armory_kiosk.scriptables )
    {
        var1 setscriptablepartstate( "br_plunder_box", "visible" );
        var1.visible = 1;
    }
}

// Params 2
// Size: 0x74
function dangercircletick( var0, var1 )
{
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "kiosk" ) || getdvarint( "scr_br_kiosk_ignore_circle", 0 ) == 1 )
    {
        return;
    }
    
    var2 = var1 * var1;
    
    foreach ( var4 in level.br_armory_kiosk.scriptables )
    {
        if ( isdefined( var4.visible ) && distance2dsquared( var4.origin, var0 ) > var2 )
        {
            little_bird_mg_mp_initmines( var4 );
        }
    }
}

// Params 0
// Size: 0x4d
function little_bird_mg_initomnvars()
{
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "kiosk" ) )
    {
        return;
    }
    
    foreach ( var1 in level.br_armory_kiosk.scriptables )
    {
        if ( isdefined( var1.visible ) )
        {
            little_bird_mg_mp_initmines( var1 );
        }
    }
}

// Params 1
// Size: 0x3d
function little_bird_mg_mp_initmines( var0 )
{
    var0 setscriptablepartstate( "br_plunder_box", "disabled" );
    var0.visible = undefined;
    var0.disabled = 1;
    var0 notify( "kiosk_disabled" );
    
    if ( var0 scripts\mp\gametypes\br_quest_util::gethelispawns() )
    {
        var0 scripts\mp\gametypes\br_quest_util::lastdropedtime();
        return;
    }
}

// Params 0
// Size: 0x2b
function registeraccesscardlocs()
{
    if ( !level.br_armory_kiosk_enabled )
    {
        return;
    }
    
    if ( istrue( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "placedKiosks" ) ) )
    {
        return;
    }
    
    var0 = getentitylessscriptablearrayinradius( "scriptable_br_plunder_box", "classname" );
    return var0;
}

// Params 1
// Size: 0x65
function relic_bang_and_boom_wait_for_pickup( var0 )
{
    var1 = level.br_armory_kiosk.scriptables;
    var2 = 1e+12;
    var3 = undefined;
    
    foreach ( var5 in var1 )
    {
        if ( !istrue( var5.disabled ) )
        {
            var6 = distance2dsquared( var0, var5.origin );
            
            if ( var6 < var2 )
            {
                var3 = var5;
                var2 = var6;
            }
        }
    }
    
    return var3;
}

// Params 1
// Size: 0x11
function ref_131c0( var0 )
{
    level.br_armory_kiosk.scriptables = var0;
}

// Params 5
// Size: 0xe7
function armorykioskused( var0, var1, var2, var3, var4 )
{
    if ( istrue( level.gameended ) )
    {
        return;
    }
    
    if ( !var3 scripts\cp_mp\utility\player_utility::_isalive() || istrue( var3.inlaststand ) )
    {
        return;
    }
    
    if ( var3 scripts\cp_mp\utility\player_utility::isusingremote() )
    {
        return;
    }
    
    if ( var3 scripts\cp_mp\utility\player_utility::isinvehicle() )
    {
        return;
    }
    
    if ( istrue( var3 scripts\mp\gametypes\br_gametypes::ref_12e05( "playerSkipKioskUse", var0 ) ) )
    {
        return;
    }
    
    if ( istrue( var3.iscarrying ) && !isdefined( var3.get_search_turret_target_player ) )
    {
        var3 scripts\mp\hud_message::showerrormessage( "MP/FIELD_UPGRADE_CANNOT_USE" );
        return;
    }
    
    if ( istrue( var3.tracking_max_health ) )
    {
        var3 notify( "br_try_armor_cancel" );
    }
    
    scripts\cp\vehicles\vehicle_compass_cp::ref_120a8( "kiosk" );
    
    if ( var2 == "visible" )
    {
        if ( var0.type != "br_portable_kiosk" )
        {
            var0 setscriptablepartstate( "br_plunder_box", "opening" );
        }
        
        thread wait_for_anyone_nearby_hint();
        thread _runpurchasemenu( var3 );
        return;
    }
    
    if ( var2 == "opening" || var2 == "open" )
    {
        thread _runpurchasemenu( var3 );
        return;
    }
}

// Params 0
// Size: 0x24
function wait_for_anyone_nearby_hint()
{
    if ( !getdvarint( "scr_br_kiosk_fix_prone_players", 1 ) )
    {
        return;
    }
    
    var0 = getdvarfloat( "scr_br_kiosk_fix_prone_players_radius", 300 );
    scripts\mp\gametypes\br_functional_poi::player_give_intel_1_ks( var0 );
}

// Params 2
// Size: 0x6e
function wait_for_enemies_inarea( var0, var1 )
{
    if ( !isdefined( var0.playdeathanim_groundturret ) )
    {
        var0.playdeathanim_groundturret = [ var1 ];
    }
    else if ( !scripts\engine\utility::array_contains( var0.playdeathanim_groundturret, var1 ) )
    {
        var0.playdeathanim_groundturret = scripts\engine\utility::array_add( var0.playdeathanim_groundturret, var1 );
    }
    
    if ( !var0 scripts\mp\gametypes\br_quest_util::gethelispawns() )
    {
        var0 scripts\mp\gametypes\br_quest_util::init_tape_machine_animations( "ui_mp_br_mapmenu_icon_poi_plunder_box_firesale", "active", var0.origin );
    }
    
    var0 scripts\mp\gametypes\br_quest_util::ref_1336c( var1 );
}

// Params 2
// Size: 0x34
function unstable_gauge_timer_active( var0, var1 )
{
    if ( scripts\mp\gametypes\br_publicevents::upload_station_interact_used_think( 2 ) )
    {
        return 1;
    }
    
    if ( !isdefined( var0 ) || !isdefined( var0.playdeathanim_groundturret ) )
    {
        return 0;
    }
    
    return scripts\engine\utility::array_contains( var0.playdeathanim_groundturret, var1 );
}

// Params 2
// Size: 0x2e
function wait_for_all_traps_disabled( var0, var1 )
{
    if ( !isdefined( var0.playdeathanim_groundturret ) )
    {
        return;
    }
    
    var0 scripts\mp\gametypes\br_quest_util::spawn_downed_friendly( var1 );
    var0.playdeathanim_groundturret = scripts\engine\utility::array_remove( var0.playdeathanim_groundturret, var1 );
}

// Params 0
// Size: 0x16
function removefromdismembermentlist()
{
    return 180 + randomfloatrange( -10, 10 );
}

// Params 2
// Size: 0x64
function ref_13169( var0, var1 )
{
    foreach ( var3 in level.players )
    {
        var4 = "ui_br_kiosk_ban_" + var0;
        
        if ( var4 == "ui_br_kiosk_ban_supply_drop" )
        {
            var5 = scripts\engine\utility::ter_op( var1, 1, 0 );
            ref_1260d( var3, var4, var5, 0, 1 );
            continue;
        }
        
        var3 setclientomnvar( var4, var1 );
    }
}

// Params 2
// Size: 0xe9
function _runpurchasemenu( var0, var1 )
{
    var2 = self;
    level endon( "game_ended" );
    var2 endon( "disconnect" );
    var2 endon( "death" );
    var2.delay_kick_inactive_player = var0;
    
    if ( scripts\mp\gametypes\br_public::tutorial_playsound() )
    {
        var2 notify( "kiosk_used" );
    }
    
    var3 = unstable_gauge_timer_active( var0, var2 );
    var4 = var2 scripts\mp\utility\perk::_hasperk( "specialty_br_cheaper_kiosk" );
    applyscripteddiscounts( var2 );
    
    if ( istrue( var1 ) )
    {
        var3 = 0;
        var4 = 0;
    }
    
    if ( isdefined( level.dialog_wait_ready_civ ) && !istrue( var2.delete_silo_lights ) )
    {
        var2 setclientomnvar( "ui_br_purchase_file_override", level.dialog_wait_ready_civ );
    }
    
    var2 setclientomnvar( "ui_br_purchase_killstreak_response", 0 );
    
    if ( var3 )
    {
        var2 setclientomnvar( "ui_br_open_purchase_killstreak", 2 );
    }
    else if ( var4 )
    {
        var2 setclientomnvar( "ui_br_open_purchase_killstreak", 3 );
    }
    else
    {
        var2 setclientomnvar( "ui_br_open_purchase_killstreak", 1 );
    }
    
    var2.armorykioskpurchaseallowed = 1;
    scripts\mp\gametypes\br_analytics::destructable_car( var2, "menu_open" );
    thread apc_target_enemies( var2 );
    var2 setsoundsubmix( "iw8_br_plunder_kiosk_menu" );
}

// Params 1
// Size: 0x79
function addtop3brcharge( var0 )
{
    var1 = self;
    var1 setclientomnvar( "ui_br_purchase_killstreak_response", var0 );
    var1 setclientomnvar( "ui_br_open_purchase_killstreak", 0 );
    var1 setclientomnvar( "ui_br_purchase_file_override", -1 );
    var1 clearsoundsubmix( "iw8_br_plunder_kiosk_menu" );
    scripts\cp_mp\vehicles\vehicle_interact::ref_141a8( var1.ref_1424d, var1 );
    var1.delay_kick_inactive_player = undefined;
    var1.delete_silo_lights = undefined;
    var1.ref_1424d = undefined;
    var1.armorykioskpurchaseallowed = undefined;
    var1 notify( "purchase_menu_closed", var0 );
    scripts\mp\gametypes\br_analytics::destructable_car( var1, "menu_close", "reason: " + var0 );
}

// Params 1
// Size: 0x14
function ally_charge_dialogue( var0 )
{
    addtop3brcharge( var0, 0 );
    var0 notify( "_watchToAutoCloseMenu_end" );
}

// Params 1
// Size: 0x58
function apc_target_enemies( var0 )
{
    var1 = self;
    var1 endon( "disconnect" );
    var1 notify( "_watchToAutoCloseMenu_end" );
    var1 endon( "_watchToAutoCloseMenu_end" );
    GscBinSkip4( 0x6e, var1, var0 );
    // Unknown operator ( 0x6e, iw8, PC )
}

// Params 1
// Size: 0x64
function ally1_intro_dialogue( var0 )
{
    var1 = self;
    var2 = 64;
    var3 = getdvarfloat( "MLLSRQSRT", 128 ) + var2;
    var4 = var3 * var3;
    
    for ( ;; )
    {
        wait 0.1;
        
        if ( !isdefined( var1 ) || !isdefined( var0 ) )
        {
            break;
        }
        
        var5 = distancesquared( var1.origin, var0.origin );
        
        if ( isdefined( var5 ) && var5 > var4 )
        {
            var1 notify( "pushed_too_far" );
            break;
        }
    }
}

// Params 1
// Size: 0x28
function ai_rush_players_thread( var0 )
{
    var1 = self;
    
    if ( !isdefined( var0 ) )
    {
        return 0;
    }
    
    var2 = var1 scripts\mp\equipment::getequipmentammo( var0 );
    var3 = var1 scripts\mp\equipment::getequipmentmaxammo( var0 );
    return max( 0, var3 - var2 );
}

// Params 1
// Size: 0x30
function allowattackfromexposednonode( var0 )
{
    var1 = self;
    
    if ( !isdefined( var0 ) )
    {
        return 0;
    }
    
    var2 = var1 scripts\mp\equipment::getequipmentammo( var0 );
    var3 = var1 scripts\mp\equipment::getequipmentmaxammo( var0 );
    
    if ( var2 < var3 )
    {
        var1 scripts\mp\equipment::setequipmentammo( var0, var3 );
        return;
    }
}

// Params 2
// Size: 0xa1
function ai_molotov_swap( var0, var1 )
{
    var2 = self;
    var3 = var2 scripts\mp\equipment::getequipmentslotammo( "health" );
    
    if ( !isdefined( var3 ) )
    {
        var3 = 0;
    }
    
    var4 = var2 scripts\mp\equipment::getequipmentmaxammo( "equip_armorplate" );
    
    if ( getdvarint( "scr_br_alt_mode_gg", 0 ) )
    {
        var5 = 2;
    }
    else
    {
        var5 = 5;
    }
    
    var6 = int( clamp( var5, 0, var5 - var4 ) );
    var7 = var5 - var6;
    
    if ( var7 > 0 && !istrue( var2 ) )
    {
        var8 = undefined;
        
        if ( istrue( var1 ) )
        {
            var8 = removefromdismembermentlist();
        }
        
        var9 = scripts\mp\gametypes\br_pickups::test_ai_anim();
        var10 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles( var9, var3.origin, var3.angles, var3, var8 );
        scripts\mp\gametypes\br_pickups::spawnpickup( "brloot_armor_plate", var10, var7, 1 );
    }
    
    return var6;
}

// Params 3
// Size: 0x4ab, Type: bool
function apc_rus_initdamage( var0, var1, var2 )
{
    var3 = self;
    var4 = getbestscripteddiscount( var0.ref );
    var5 = unstable_gauge_timer_active( var3.delay_kick_inactive_player, var3 );
    var6 = var3 scripts\mp\utility\perk::_hasperk( "specialty_br_cheaper_kiosk" );
    var7 = ai_push_to_position( var0, var0.cost, var5, var0.playboxuseanimation, var6, var0.ref_122fc, var4 );
    
    if ( !isdefined( var3.plundercount ) )
    {
        var3.plundercount = 0;
    }
    
    if ( var3.plundercount < var7 )
    {
        addtop3brcharge( var3, 3 );
        return false;
    }
    
    if ( var0.type == "killstreak" )
    {
        if ( var0.ref == "juggernaut" )
        {
            if ( var3 scripts\mp\utility\killstreak::isjuggernaut() )
            {
                addtop3brcharge( var3, 4 );
                return false;
            }
            else if ( var3 scripts\mp\juggernaut::changecirclestateatlowtime() )
            {
                addtop3brcharge( var3, 27 );
                return false;
            }
        }
        
        if ( !istrue( var1 ) )
        {
            if ( var3 scripts\mp\gametypes\br_pickups::haskillstreak( var0.ref ) )
            {
                addtop3brcharge( var3, 4 );
                return false;
            }
        }
    }
    else if ( var0.type == "fieldupgrade" )
    {
        if ( var3 scripts\mp\supers::issuperinuse() )
        {
            addtop3brcharge( var3, 6 );
            return false;
        }
        
        if ( !istrue( var1 ) )
        {
            var8 = var3 scripts\mp\supers::getcurrentsuperref();
            
            if ( isdefined( var8 ) && var0.ref == var8 )
            {
                addtop3brcharge( var3, 5 );
                return false;
            }
        }
    }
    else if ( var0.type == "special" )
    {
        switch ( var0.ref )
        {
            case "armor_bundle":
            case "armor":
                break;
            case "gas_mask":
                if ( istrue( var2 ) )
                {
                    return true;
                }
                
                var9 = spawnstruct();
                var9.scriptablename = "brloot_equip_gasmask";
                var10 = scripts\mp\gametypes\br_pickups::cantakepickup( var9 );
                break;
            case "gas_mask_durable":
                if ( istrue( var2 ) )
                {
                    return true;
                }
                
                var9 = spawnstruct();
                var9.scriptablename = "brloot_equip_gasmask_durable";
                var10 = scripts\mp\gametypes\br_pickups::cantakepickup( var9 );
                break;
            case "ammo_refill":
                if ( istrue( var2 ) )
                {
                    return true;
                }
                
                var11 = 0;
                
                if ( ai_rush_players_thread( var3, var3.equipment[ "primary" ] ) > 0 )
                {
                    var11 = 1;
                }
                else if ( ai_rush_players_thread( var3, var3.equipment[ "secondary" ] ) > 0 )
                {
                    var11 = 1;
                }
                else if ( !var3 scripts\mp\gametypes\br_weapons::debug_spawnallaccesscards() )
                {
                    var11 = 1;
                }
                
                if ( !var11 )
                {
                    addtop3brcharge( var3, 8 );
                    return false;
                }
                
                break;
            case "respawn_token":
                if ( scripts\mp\gametypes\br_pickups::ref_12cb6() )
                {
                    addtop3brcharge( var3, 9 );
                    return false;
                }
                
                if ( istrue( var2 ) )
                {
                    return true;
                }
                
                if ( istrue( var3.hasrespawntoken ) )
                {
                    addtop3brcharge( var3, 10 );
                    return false;
                }
                
                break;
            case "self_revive_token":
                if ( var3 scripts\mp\utility\killstreak::isjuggernaut() )
                {
                    addtop3brcharge( var3, 24 );
                    return false;
                }
                
                if ( istrue( var2 ) )
                {
                    return true;
                }
                
                if ( var3 scripts\mp\gametypes\br_public::shouldgetnewspawnpoint() )
                {
                    addtop3brcharge( var3, 10 );
                    return false;
                }
                
                break;
            case "supply_drop":
                if ( istrue( var2 ) )
                {
                    return true;
                }
                
                var9 = spawnstruct();
                var9.scriptablename = "brloot_offhand_advancedsupplydrop";
                var9.count = 1;
                var10 = scripts\mp\gametypes\br_pickups::cantakepickup( var9 );
                
                if ( var10 != 1 )
                {
                    addtop3brcharge( var3, 7 );
                    return false;
                }
                
                break;
            case "circle_pick":
                if ( isdefined( level.br_circle ) )
                {
                    addtop3brcharge( var3, 17 );
                    return false;
                }
                
                break;
            case "redeploy":
                if ( !istrue( level.brking_initdialog ) && ( isdefined( level.br_circle ) || istrue( level.disable_super_in_turret.gulagfixuparena ) ) )
                {
                    addtop3brcharge( var3, 9 );
                    return false;
                }
                
                break;
            case "vehicle_repair":
                if ( !addspecialistbonuspickup( var3 ) )
                {
                    addtop3brcharge( var3, 21 );
                    return false;
                }
                
                break;
            case "vehicle_upgrade_armor":
                if ( !addteabagcharge( var3, "armor" ) )
                {
                    addtop3brcharge( var3, 20 );
                    return false;
                }
                
                break;
            case "vehicle_refill_trophy":
                if ( !addtenkillcharge( var3 ) )
                {
                    addtop3brcharge( var3, 19 );
                    return false;
                }
                
                break;
            case "vehicle_upgrade_trophy":
                if ( !addteabagcharge( var3, "trophy" ) )
                {
                    addtop3brcharge( var3, 20 );
                    return false;
                }
                
                break;
            case "vehicle_upgrade_uav":
                if ( !addteabagcharge( var3, "uav" ) )
                {
                    addtop3brcharge( var3, 20 );
                    return false;
                }
                
                break;
            case "vehicle_upgrade_barrel":
                if ( !addteabagcharge( var3, "barrel" ) )
                {
                    addtop3brcharge( var3, 20 );
                    return false;
                }
                
                break;
            case "vehicle_replace":
                if ( var3 scripts\mp\supers::issuperinuse() )
                {
                    addtop3brcharge( var3, 6 );
                    return false;
                }
                
                if ( announcedomplatespawns( var3 ) )
                {
                    addtop3brcharge( var3, 23 );
                    return false;
                }
                
                if ( !addspecialistdialog( var3 ) )
                {
                    addtop3brcharge( var3, 22 );
                    return false;
                }
                
                break;
            case "specialist_perk":
                if ( var3 scripts\mp\gametypes\br_public::shouldlink() )
                {
                    addtop3brcharge( var3, 26 );
                    return false;
                }
                
                break;
        }
    }
    
    return true;
}

// Params 1
// Size: 0x39
function allow_ascender_use( var0 )
{
    switch ( var0 )
    {
        case "toma_strike":
        case "precision_airstrike":
            return 1;
        case "uav":
            return 0;
        case "juggernaut":
            return 0;
        default:
            return 0;
    }
}

// Params 0
// Size: 0x1f
function allow_deleteme_path()
{
    var0 = self;
    scripts\engine\utility::waittill_any_ents( var0, "death", level, "game_ended" );
    var0 notify( "cancel_location" );
}

// Params 1
// Size: 0x26
function _preventrepeatingsplash( var0 )
{
    var1 = "NewLimitedSplash" + var0;
    self notify( var1 );
    self endon( var1 );
    self.ä
8"ˇƒq‰&ËSìÒ = var0;
    wait 2;
    self.ä
8"ˇƒq‰&ËSìÒ = undefined;
}

// Params 1
// Size: 0x29
function _showsplashlimited( var0 )
{
    var1 = isdefined( self.ä
8"ˇƒq‰&ËSìÒ ) && self.ä
8"ˇƒq‰&ËSìÒ == var0;
    thread _preventrepeatingsplash( var0 );
    
    if ( var1 )
    {
        return;
    }
    
    thread scripts\mp\hud_message::showsplash( var0 );
}

// Params 3
// Size: 0x246
function aigroundturret_shouldmountturret( var0, var1, var2 )
{
    var3 = self;
    var3 endon( "disconnect" );
    var4 = getdvarint( "scr_br_activateKSOnPurchase", 0 );
    
    if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "activateKillstreakOnPurchase" ) )
    {
        var5 = scripts\mp\gametypes\br_gametypes::ref_12e05( "activateKillstreakOnPurchase", var0.ref );
        
        if ( isdefined( var5 ) )
        {
            var4 = var5;
        }
    }
    
    if ( !var4 )
    {
        var3 scripts\mp\gametypes\br_pickups::playerpackdataintogulagomnvar( var0.ref, var1, 1, var2 );
        _makekioskpurchase( var3, var0, var0.cost, var0.playboxuseanimation, var0.ref_122fc, var0.¨d˙®a;/]Ucè–Eõ∞ );
        var3 thread scripts\mp\hud_message::showsplash( "br_killstreak_purchased" );
        var3 scripts\cp\vehicles\vehicle_compass_cp::ref_1204b( "killstreak", var0.ref );
        scripts\mp\gametypes\br_analytics::destructiblecarlightssetup( self, var0.cost, "killstreak", var0.ref );
        return;
    }
    
    if ( allow_ascender_use( var0.ref ) )
    {
        var6 = var3.delay_kick_inactive_player;
        addtop3brcharge( var3, 16 );
        var3 scripts\cp_mp\utility\player_utility::_freezecontrols( 1, undefined, "kiosk" );
        var3 beginlocationselection( 0, 0, 0, 0, 4 );
        GscBinSkip4( 0x6e, var3 );
        // Unknown operator ( 0x6e, iw8, PC )
    }
    
    var9 = var4 scripts\mp\gametypes\br_pickups::forceusekillstreak( var1.ref );
    
    if ( istrue( var9 ) )
    {
        _makekioskpurchase( var4, var1, var1.cost, var1.playboxuseanimation, var1.ref_122fc, var1.¨d˙®a;/]Ucè–Eõ∞ );
        var4 thread scripts\mp\hud_message::showsplash( "br_killstreak_purchased_and_activated" );
        scripts\cp\vehicles\vehicle_compass_cp::ref_1204b( "killstreak", var1.ref );
        scripts\mp\gametypes\br_analytics::destructiblecarlightssetup( self, var1.cost, "killstreak", var1.ref );
        return;
    }
}

// Params 3
// Size: 0x89
function aigroundturret_shouldcompletedismount( var0, var1, var2 )
{
    scripts\mp\gametypes\br_pickups::forcegivesuper( var0.ref, var1, 1, var2 );
    _makekioskpurchase( var0, var0.cost, var0.playboxuseanimation, var0.ref_122fc, var0.¨d˙®a;/]Ucè–Eõ∞ );
    thread scripts\mp\hud_message::showsplash( "br_field_upgrade_purchased" );
    scripts\cp\vehicles\vehicle_compass_cp::ref_1204b( "fieldUpgrade", var0.ref );
    scripts\mp\gametypes\br_analytics::destructiblecarlightssetup( self, var0.cost, "fieldUpgrade", var0.ref );
    
    if ( level.allowsupers && !istrue( var2 ) )
    {
        scripts\mp\supers::givesuperpoints( scripts\mp\supers::getsuperpointsneeded() );
    }
}

// Params 3
// Size: 0x6d0
function aigroundturretref( var0, var1, var2 )
{
    var3 = self;
    var4 = 1;
    var5 = 1;
    var6 = undefined;
    
    switch ( var0.ref )
    {
        case "armor":
            var4 = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem( var3, "brloot_armor_plate", 1, undefined, 1, var2 );
            break;
        case "armor_bundle":
            var7 = ai_molotov_swap( var3, 1 );
            
            if ( var7 <= 0 )
            {
                var4 = 1;
            }
            else
            {
                var4 = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem( var3, "brloot_armor_plate", 1, var7, 1, var2 );
            }
            
            break;
        case "gas_mask":
            var4 = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem( var3, "brloot_equip_gasmask", 1, undefined, 1, var2 );
            break;
        case "gas_mask_durable":
            var4 = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem( var3, "brloot_equip_gasmask_durable", 1, undefined, 1, var2 );
            break;
        case "ammo_refill":
            var3 scripts\mp\gametypes\br_weapons::debug_spawncover_badnodetest();
            allowattackfromexposednonode( var3, var3.equipment[ "primary" ] );
            allowattackfromexposednonode( var3, var3.equipment[ "secondary" ] );
            break;
        case "respawn_token":
            var3 scripts\mp\gametypes\br_pickups::addrespawntoken();
            var5 = 0;
            break;
        case "self_revive_token":
            if ( istrue( var2 ) )
            {
                var4 = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem( var3, "brloot_self_revive", 1, undefined, 1, var2 );
            }
            else
            {
                var3 scripts\mp\gametypes\br_pickups::bdroppingshield();
            }
            
            var5 = 0;
            break;
        case "zxp_stim":
            var4 = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem( var3, "brloot_zmb_stim", 1, undefined, 1, 1 );
            break;
        case "supply_drop":
            var4 = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem( var3, "brloot_offhand_advancedsupplydrop", 1, undefined, 1, var2 );
            break;
        case "circle_pick":
            var4 = ref_125c1( var3 );
            break;
        case "redeploy":
            var4 = ref_125c4( var3 );
            break;
        case "vehicle_repair":
            var4 = airdrop_applyimmediatejuggernaut( var3 );
            break;
        case "vehicle_upgrade_armor":
            var4 = airdrop_bronloadoutcratedestroyed( var3, "armor" );
            break;
        case "vehicle_refill_trophy":
            var4 = airdop_brloadoutcratefirstactivation( var3, "trophy" );
            break;
        case "vehicle_upgrade_trophy":
            var4 = airdrop_bronloadoutcratedestroyed( var3, "trophy" );
            break;
        case "vehicle_upgrade_uav":
            var4 = airdrop_bronloadoutcratedestroyed( var3, "uav" );
            break;
        case "vehicle_upgrade_barrel":
            var4 = airdrop_bronloadoutcratedestroyed( var3, "barrel" );
            break;
        case "vehicle_replace":
            var4 = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem( var3, "brloot_offhand_advancedvehicledrop", 1, undefined, 1, var2 );
            break;
        case "bombardment_ltm":
            var8 = getdvarfloat( "scr_bombardment_duration", 60 );
            var9 = getdvarfloat( "scr_bombardment_radius", 4112 );
            
            if ( isdefined( level.create_exfil_animstruct ) && isdefined( level.ref_14687 ) && isdefined( level.ref_14687.ref_11ae9 ) )
            {
                var10 = undefined;
                
                foreach ( var12 in level.create_exfil_animstruct )
                {
                    if ( var12.refname == level.ref_14687.ref_11ae9 )
                    {
                        var10 = var12;
                    }
                }
                
                if ( isdefined( var10 ) )
                {
                    level.create_ai_type_override = var10.ref_119a7;
                    var9 = var10.ref_119a8;
                }
            }
            
            var4 = level _hidesafecircleui::changetimertoovertimetimer( level.create_ai_type_override, var3, var8, var9 );
            
            if ( var4 )
            {
                var3 scripts\mp\gametypes\br_pickups::ref_12bfc();
            }
            
            break;
        case "build_checkpoint":
            var4 = scripts\mp\gametypes\br_gametype_payload::firesalediscount( var3, var3.delay_kick_inactive_player );
            break;
        case "build_tower":
            var4 = scripts\mp\gametypes\br_gametype_payload::fix_wall_traversal( var3, var3.delay_kick_inactive_player );
            break;
        case "random_powerup":
            var3 _keypadscriptableused_bunkeralt::script_model_spawn_and_use_logic();
            var5 = 0;
            break;
        case "specialist_perk":
            var3 scripts\mp\gametypes\br_pickups::bearsetup( 0 );
            var4 = 1;
            
            if ( var3 calloutmarkerping_entityzoffset( "ui_br_purchase_file_override" ) == 8 )
            {
                var3 reportchallengeuserevent( "collect_item", "dragons_den_blackmarket" );
            }
            
            break;
        case "pac_sentry_kiosk":
            var4 = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem( var3, "brloot_killstreak_sentrygun", 1, undefined, 1, var2 );
            break;
        case "circle_bombardment":
            if ( isdefined( level.br_circle ) && isdefined( level.br_circle.safecircleent ) )
            {
                var4 = level _hidesafecircleui::changing_loadout( var3 );
            }
            else
            {
                scripts\mp\utility\script::laststand_dogtags( "No safe circle ent defined" );
                var4 = 0;
            }
            
            if ( !var4 )
            {
                addtop3brcharge( var3, 28 );
            }
            
            break;
        case "kiosk_drop":
            var4 = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem( var3, "brloot_offhand_kioskdrop", 1, undefined, 1, var2 );
            break;
        case "numbers_grenade":
            var4 = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem( var3, "brloot_offhand_numbers_grenade", 1, undefined, 1, var2 );
            
            if ( var3 calloutmarkerping_entityzoffset( "ui_br_purchase_file_override" ) == 8 )
            {
                var3 reportchallengeuserevent( "collect_item", "dragons_den_blackmarket" );
            }
            
            break;
        case "nebula_v_rounds":
            var4 = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem( var3, "brloot_super_nova_rounds", 1, undefined, 1, var2 );
            
            if ( var3 calloutmarkerping_entityzoffset( "ui_br_purchase_file_override" ) == 8 )
            {
                var3 reportchallengeuserevent( "collect_item", "dragons_den_blackmarket" );
            }
            
            break;
        case "pds":
            var4 = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem( var3, "brloot_offhand_decon_station", 1, undefined, 1, var2 );
            
            if ( var3 calloutmarkerping_entityzoffset( "ui_br_purchase_file_override" ) == 8 )
            {
                var3 reportchallengeuserevent( "collect_item", "dragons_den_blackmarket" );
            }
            
            break;
        case "redacted_ar":
            var4 = scripts\mp\gametypes\br_black_market_quest::redacted_weapon_purchase( var3, "brloot_weapon_s4_ar_asierra44_ultr", 1, undefined, 1, var2 );
            break;
        case "redacted_smg":
            var4 = scripts\mp\gametypes\br_black_market_quest::redacted_weapon_purchase( var3, "brloot_weapon_s4_sm_owhiskey_ultr", 1, undefined, 1, var2 );
            break;
        case "redacted_shotgun":
            var4 = scripts\mp\gametypes\br_black_market_quest::redacted_weapon_purchase( var3, "brloot_weapon_s4_sh_bromeo5_ultr", 1, undefined, 1, var2 );
            break;
        case "redacted_sniper":
            var4 = scripts\mp\gametypes\br_black_market_quest::redacted_weapon_purchase( var3, "brloot_weapon_s4_mr_moscar_ultr", 1, undefined, 1, var2 );
            break;
        case "redacted_lmg":
            var4 = scripts\mp\gametypes\br_black_market_quest::redacted_weapon_purchase( var3, "brloot_weapon_s4_mg_mgolf42_ultr", 1, undefined, 1, var2 );
            break;
        case "nebula_v_special":
            var4 = scripts\mp\gametypes\br_black_market_quest::redacted_weapon_purchase( var3, "brloot_weapon_lm_dblmg_lege", 1, undefined, 1, var2 );
            break;
        case "circle_peek":
            var4 = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem( var3, "brloot_killstreak_circle_peek", 1, undefined, 1, var2 );
            
            if ( var3 calloutmarkerping_entityzoffset( "ui_br_purchase_file_override" ) == 8 )
            {
                var3 reportchallengeuserevent( "collect_item", "dragons_den_blackmarket" );
            }
            
            break;
        case "contribute_heroes":
            var5 = 0;
            _showsplashlimited( var3, "br_hero_bundle" );
            break;
        case "contribute_villains":
            var5 = 0;
            _showsplashlimited( var3, "br_villain_bundle" );
            break;
        case "br_bomb":
            var5 = 0;
            _showsplashlimited( var3, "br_villain_bundle" );
            break;
        case "br_defusekit":
            var5 = 0;
            _showsplashlimited( var3, "br_hero_bundle" );
            break;
        default:
            break;
    }
    
    if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "kiosk_onPurchase" ) )
    {
        scripts\mp\gametypes\br_gametypes::ref_12e05( "kiosk_onPurchase", var3, var0.ref );
    }
    
    if ( var4 )
    {
        _makekioskpurchase( var3, var0, var0.cost, var0.playboxuseanimation, var0.ref_122fc, var0.¨d˙®a;/]Ucè–Eõ∞ );
        
        if ( var5 )
        {
            var3 thread scripts\mp\hud_message::showsplash( "br_item_purchased" );
        }
        
        scripts\cp\vehicles\vehicle_compass_cp::ref_1204b( "special", var0.ref );
        scripts\mp\gametypes\br_analytics::destructiblecarlightssetup( self, var0.cost, "special", var0.ref );
        return;
    }
}

// Params 2
// Size: 0x201, Type: bool
function aigroundturretstate( var0, var1 )
{
    var2 = ( 1, 1, 1 );
    var3 = ( 1, 0, 0 );
    var4 = ( 0, 1, 0 );
    var5 = ( 0, 1, 1 );
    var6 = 3;
    var7 = 8;
    var8 = self.delay_kick_inactive_player.origin;
    
    if ( !scripts\cp_mp\vehicles\vehicle_tracking::canspawnvehicle() )
    {
        return false;
    }
    
    if ( scripts\cp_mp\utility\player_utility::isinvehicle( 1 ) )
    {
        return false;
    }
    
    var9 = physics_createcontents( [ "physicscontents_solid", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicleclip" ] );
    var10 = 300;
    var11 = 90;
    var12 = 300;
    var13 = 150;
    var14 = var13 + var10;
    var15 = 0;
    var16 = undefined;
    var17 = undefined;
    var18 = undefined;
    
    while ( var15 < 360 )
    {
        var19 = var8 + ( sin( var15 ) * var10, cos( var15 ) * var10, 0 );
        var16 = ( var19[ 0 ], var19[ 1 ], var19[ 2 ] + var14 );
        var17 = ( var19[ 0 ], var19[ 1 ], var19[ 2 ] - var14 );
        var20 = physics_spherecast( var16, var17, var12, var9, undefined, "physicsquery_closest" );
        
        if ( var20.size > 0 )
        {
            var21 = var20[ 0 ][ "position" ];
            var17 = ( var16[ 0 ], var16[ 1 ], var20[ 0 ][ "shape_position" ][ 2 ] - var10 );
            
            if ( !isdefined( var20[ 0 ][ "entity" ] ) && abs( var17[ 2 ] - var19[ 2 ] ) < var13 )
            {
                if ( !isdefined( var18 ) )
                {
                    var18 = var17 + ( 0, 0, var10 );
                    
                    if ( !getdvarint( "scr_vehicleKioskFindAllSpawns", 0 ) > 0 )
                    {
                        break;
                    }
                }
            }
        }
        
        var14 += var10;
    }
    
    if ( !isdefined( var17 ) )
    {
        return false;
    }
    
    var22 = 150;
    var23 = spawnstruct();
    var23.origin = var17 + ( 0, 0, var22 );
    var23.angles = ( 0, randomintrange( 0, 360 ), 0 );
    var23.owner = self;
    var23.spawntype = "GAME_MODE";
    var24 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle( <error>.ref, var23 );
    
    if ( !isdefined( var24 ) )
    {
        return false;
    }
    
    var25 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverseat( var24 );
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter( var24, var25, self );
    scripts\cp_mp\vehicles\vehicle_spawn::ref_14219( var24 );
    return true;
}

// Params 0
// Size: 0x2c, Type: bool
function addspecialistbonuspickup()
{
    var0 = self;
    var1 = var0.ref_1424d;
    
    if ( isdefined( var1 ) )
    {
        if ( var1.health == var1.maxhealth )
        {
            return false;
        }
        
        return true;
    }
    
    return false;
}

// Params 0
// Size: 0x47, Type: bool
function addtenkillcharge()
{
    var0 = self;
    var1 = var0.ref_1424d;
    
    if ( isdefined( var1 ) )
    {
        if ( isdefined( var1.ref_13ddf ) && isdefined( var1.ref_11b7b ) && var1.ref_13ddf == var1.ref_11b7b )
        {
            return false;
        }
        else
        {
            return true;
        }
    }
    
    return false;
}

// Params 1
// Size: 0x2b, Type: bool
function addteabagcharge( var0 )
{
    var1 = self;
    var2 = var1.ref_1424d;
    
    if ( isdefined( var2 ) )
    {
        if ( scripts\cp_mp\vehicles\vehicle_interact::ref_141ac( var2, var0 ) )
        {
            return false;
        }
        else
        {
            return true;
        }
    }
    
    return false;
}

// Params 2
// Size: 0xc9, Type: bool
function airdrop_applyimmediatejuggernaut( var0, var1 )
{
    var2 = self;
    var3 = var2.ref_1424d;
    
    if ( isdefined( var3 ) )
    {
        if ( var3.health == var3.maxhealth )
        {
            return false;
        }
        
        var4 = getdvarfloat( "truck_repair_health_percent", 0.25 );
        var5 = int( var3.maxhealth * var4 );
        var3 scripts\cp_mp\vehicles\vehicle_damage::ref_1413c( var5 );
        var6 = scripts\mp\utility\teams::getteamdata( self.team, "players" );
        
        foreach ( var2 in var6 )
        {
            if ( getdvarint( "scr_truckwar_repair_show_player_feedback", 1 ) == 1 )
            {
                var2 scripts\mp\damagefeedback::hudicontype( "truckheal" );
            }
            
            var2 _calloutmarkerping_handleluinotify_added::ref_13133( "ui_br_team_cash_pockets", var3.health );
            var2 _calloutmarkerping_handleluinotify_added::ref_13133( "ui_br_team_cash_banked", var3.maxhealth );
        }
        
        return true;
    }
    
    return false;
}

// Params 1
// Size: 0x23, Type: bool
function airdop_brloadoutcratefirstactivation( var0 )
{
    var1 = self;
    var2 = var1.ref_1424d;
    
    if ( isdefined( var2 ) )
    {
        scripts\cp_mp\vehicles\vehicle_interact::ref_141a4( var2, var0, var1 );
        return true;
    }
    
    return false;
}

// Params 1
// Size: 0x34, Type: bool
function airdrop_bronloadoutcratedestroyed( var0 )
{
    var1 = self;
    var2 = var1.ref_1424d;
    
    if ( isdefined( var2 ) )
    {
        if ( scripts\cp_mp\vehicles\vehicle_interact::ref_141ac( var2, var0 ) )
        {
            return false;
        }
        else
        {
            scripts\cp_mp\vehicles\vehicle_interact::ref_141a4( var2, var0, var1 );
            return true;
        }
    }
    
    return false;
}

// Params 0
// Size: 0x96, Type: bool
function announcedomplatespawns()
{
    var0 = self;
    var1 = scripts\mp\utility\teams::getteamdata( var0.team, "players" );
    
    foreach ( var3 in var1 )
    {
        if ( isdefined( var3 ) )
        {
            var4 = var3 scripts\mp\supers::getcurrentsuperref();
            
            if ( isdefined( var4 ) && var4 == "super_vehicle_drop" )
            {
                if ( var3 getammocount( var3.super.staticdata.weapon ) > 0 )
                {
                    return true;
                }
            }
        }
    }
    
    if ( isdefined( level.ref_13acd ) && istrue( level.ref_13acd[ var0.team ] ) )
    {
        return true;
    }
    
    return false;
}

// Params 0
// Size: 0x20, Type: bool
function addspecialistdialog()
{
    if ( isdefined( level.ref_13ace ) && !isdefined( level.ref_13ace[ self.team ] ) )
    {
        return true;
    }
    
    return false;
}

// Params 2
// Size: 0x5dd
function onarmorykioskpurchase( var0, var1 )
{
    var2 = self;
    var3 = var2.delay_kick_inactive_player;
    
    if ( !istrue( var2.armorykioskpurchaseallowed ) )
    {
        return;
    }
    
    var4 = "channel: " + var0;
    
    if ( isdefined( var1 ) )
    {
        var4 = var4 + ", index: " + var1;
    }
    
    scripts\mp\gametypes\br_analytics::destructable_car( var2, "menu_purchase", var4 );
    var5 = getdvarint( "scr_br_kioskPurchaseDropItems", 1 );
    var6 = getdvarint( "scr_br_kioskPurchaseDropPurchasedItem", 0 );
    
    if ( var2 scripts\mp\utility\killstreak::isjuggernaut() )
    {
        var6 = 1;
    }
    
    if ( var0 == "br_cancel_purchase" )
    {
        ally_charge_dialogue( var2 );
        return;
    }
    
    if ( var0 == "br_item_purchase" )
    {
        var7 = var1;
        var8 = level.br_armory_kiosk.items[ var7 ];
        var9 = apc_rus_initdamage( var2, var8, var5, var6 );
        var8.¨d˙®a;/]Ucè–Eõ∞ = getbestscripteddiscount( var2, var8.ref );
        
        if ( var9 )
        {
            if ( var8.type == "killstreak" )
            {
                thread aigroundturret_shouldmountturret( var2, var8, var5 );
            }
            else if ( var8.type == "fieldupgrade" )
            {
                aigroundturret_shouldcompletedismount( var2, var8, var5, var6 );
            }
            else if ( var8.type == "special" )
            {
                aigroundturretref( var2, var8, var5, var6 );
            }
            else if ( var8.type == "vehicle" )
            {
                var10 = aigroundturretstate( var2, var8, var5 );
                
                if ( var10 )
                {
                    _makekioskpurchase( var2, var8, var8.cost, var8.playboxuseanimation, var8.ref_122fc, var8.í–√yÿÎ=3ÒHAZ-VŸ, var0 );
                    var2 thread scripts\mp\hud_message::showsplash( "br_vehicle_purchased" );
                    scripts\mp\gametypes\br_analytics::destructiblecarlightssetup( self, var8.cost, "vehicle", var8.ref );
                }
                else
                {
                    var2 scripts\mp\hud_message::showerrormessage( "MP/VEHICLE_PURCHASE_FAILED" );
                }
            }
        }
        
        return;
    }
    
    if ( var0 == "br_loadout_purchase" )
    {
        var7 = var1;
        var8 = level.br_armory_kiosk.items[ var7 ];
        var11 = unstable_gauge_timer_active( var2.delay_kick_inactive_player, var2 );
        var12 = var2 scripts\mp\utility\perk::_hasperk( "specialty_br_cheaper_kiosk" );
        var13 = 0;
        var14 = var1;
        var15 = level.br_armory_kiosk.ref_11955;
        var16 = level.br_armory_kiosk.ref_11956;
        var17 = level.br_armory_kiosk.ref_11957;
        var18 = getbestscripteddiscount( var2, var8.ref );
        
        if ( scripts\mp\menus::update_enemies_remaining( var14 ) )
        {
            var15 = level.br_armory_kiosk.ref_11958;
            var16 = level.br_armory_kiosk.ref_11959;
            var17 = level.br_armory_kiosk.ref_1195a;
            var13 = 1;
        }
        
        var19 = ai_push_to_position( var8, var15, var11, var16, var12, var17, var18 );
        
        if ( var2.plundercount < var19 )
        {
            addtop3brcharge( var2, 3 );
            return;
        }
        
        var20 = scripts\mp\menus::getclasschoice( var14 );
        scripts\mp\gametypes\br_analytics::destroyscorelaunchonly( self, "purchasing_new_loadout" );
        var2.pers[ "class" ] = var20;
        var2.class = var20;
        var21 = var2 scripts\mp\class::preloadandqueueclass( var20 );
        scripts\mp\gametypes\br::delay_delete_reinforcement_called_icon( var2, var5 );
        _makekioskpurchase( var2, var8, var15, var16, var17, var18, var0 );
        var2 thread scripts\mp\hud_message::showsplash( "br_loadout_purchased" );
        
        if ( istrue( var13 ) )
        {
            scripts\mp\gametypes\br_analytics::destructiblecarlightssetup( self, var19, "defaultLoadout", "loadout_" + var14 );
        }
        else
        {
            scripts\mp\gametypes\br_analytics::destructiblevehiclesetup( self, var19, var21 );
        }
        
        return;
    }
    
    if ( var0 == "br_team_revive" )
    {
        var22 = var1;
        var11 = unstable_gauge_timer_active( var2.delay_kick_inactive_player, var2 );
        var16 = level.br_armory_kiosk.ref_13ac3;
        var12 = var2 scripts\mp\utility\perk::_hasperk( "specialty_br_cheaper_kiosk" );
        var17 = level.br_armory_kiosk.ref_13ac4;
        var23 = "teamrevive";
        var18 = getbestscripteddiscount( var2, var23 );
        var24 = ai_push_to_position( undefined, level.br_armory_kiosk.ref_13ac2, var11, var16, var12, var17, var18 );
        var25 = !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "useTokenToReviveTeammate" );
        var26 = istrue( var2.hasrespawntoken ) && var25 && var2.plundercount < var24;
        
        if ( !var26 && var2.plundercount < var24 )
        {
            addtop3brcharge( var2, 3 );
            return 0;
        }
        
        var27 = undefined;
        var28 = scripts\mp\utility\teams::getteamdata( var2.team, "players" );
        
        foreach ( var30 in var28 )
        {
            if ( isdefined( var30.pers[ "squadMemberIndex" ] ) && var30.pers[ "squadMemberIndex" ] == var22 )
            {
                var27 = var30;
                break;
            }
        LOC_00000424:
        }
        
        if ( !isdefined( var27 ) )
        {
            addtop3brcharge( var2, 12 );
            return;
        }
        
        if ( !var27 scripts\mp\gametypes\br_public::unlockscriptabledoors() && !getdvarint( "scr_br_all_assassin_version", 0 ) )
        {
            if ( scripts\mp\gametypes\br_public::use_csm( var27 ) )
            {
                addtop3brcharge( var2, 14 );
                return;
            }
            
            if ( isalive( var27 ) )
            {
                addtop3brcharge( var2, 15 );
                return;
            }
            
            addtop3brcharge( var2, 13 );
            return;
        }
        
        var32 = 0;
        
        if ( !var26 )
        {
            var33 = level.br_armory_kiosk.ref_13ac2;
            var16 = level.br_armory_kiosk.ref_13ac3;
            var17 = level.br_armory_kiosk.ref_13ac4;
            _makekioskpurchase( var2, undefined, var33, var16, var17, var18, var0 );
            
            if ( istrue( var2.hasrespawntoken ) )
            {
                var32 = 1;
            }
            else
            {
                var2 scripts\mp\gametypes\br_pickups::addrespawntoken( 1 );
            }
            
            var2 scripts\cp\vehicles\vehicle_compass_cp::ref_1204b( "teamrevive", "teamrevive" );
            scripts\mp\gametypes\br_analytics::destructiblecarlightssetup( var2, var24, "teamrevive_money", "teamrevive" );
        }
        else
        {
            _makekioskpurchase( var2, undefined, 0, 0, 0, 0, var0 );
            var2 scripts\cp\vehicles\vehicle_compass_cp::ref_1204b( "teamrevive", "teamrevive" );
            scripts\mp\gametypes\br_analytics::destructiblecarlightssetup( var2, 0, "teamrevive_token", "teamrevive" );
        }
        
        if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "kioskRevivePlayer" ) )
        {
            var27 thread scripts\mp\gametypes\br_gametypes::ref_12e05( "kioskRevivePlayer", var2, var26 );
        }
        else
        {
            var27 thread scripts\mp\gametypes\br_gulag::playergulagautowin( "br_team_revive", var2, var26 );
        }
        
        if ( var32 )
        {
            var2 scripts\mp\gametypes\br_pickups::addrespawntoken( 1 );
        }
        
        level thread scripts\mp\gametypes\br_quest_util::ref_140b1( var3.origin, "revive" );
        var2 thread scripts\mp\hud_message::showsplash( "br_squadmate_revived" );
        
        if ( getdvarint( "OMSQPMNQLS", 0 ) && var2 scripts\mp\utility\game::onlinestatsenabled() )
        {
            var2 setplayerdata( "mp", "use_buy_back_history", 0, 1 );
        }
    }
}

// Params 6
// Size: 0x12b
function _makekioskpurchase( var0, var1, var2, var3, var4, var5 )
{
    var6 = self;
    var7 = unstable_gauge_timer_active( var6.delay_kick_inactive_player, var6 );
    var8 = var6 scripts\mp\utility\perk::_hasperk( "specialty_br_cheaper_kiosk" );
    
    if ( var7 && var2 > 0 )
    {
        wait_for_all_traps_disabled( var6.delay_kick_inactive_player, var6 );
    }
    
    if ( !( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "kioskXP" ) || scripts\mp\gametypes\br_public::turret_headicon() ) )
    {
        var6 thread scripts\mp\utility\points::giveunifiedpoints( "br_kioskBuy", undefined, scripts\mp\gametypes\br::freeze_bomb_vest_timer( var1 ), undefined, undefined, undefined, undefined, var5 );
    }
    
    var1 = ai_push_to_position( var0, var1, var7, var2, var8, var3, var4 );
    
    if ( var1 > 0 )
    {
        var6 scripts\mp\gametypes\br_plunder::ref_12622( var1 );
    }
    
    if ( !isdefined( level.br_plunder ) )
    {
        level.br_plunder = spawnstruct();
    }
    
    if ( !isdefined( level.br_plunder.wait_for_all_players_in_airlock ) )
    {
        level.br_plunder.wait_for_all_players_in_airlock = 0;
    }
    
    level.br_plunder.wait_for_all_players_in_airlock += var1;
    
    if ( !isdefined( level.br_plunder.wait_fire_mainhouse_flashbangs_and_smokes ) )
    {
        level.br_plunder.wait_fire_mainhouse_flashbangs_and_smokes = 0;
    }
    
    level.br_plunder.wait_fire_mainhouse_flashbangs_and_smokes++;
    
    if ( !level.∂≠òNØ¬ì÷∑…Â◊[Z€õ÷˙±€ÊYæk≤Ê’ØôKá )
    {
        if ( var6 scripts\engine\utility::ref_12c44( "buystationCloseMenuOnPurchase" ) )
        {
            addtop3brcharge( var6, 1 );
        }
        
        return;
    }
    
    thread playerclosebuystationmenu();
}

// Params 0
// Size: 0x3e
function playerclosebuystationmenu()
{
    self endon( "disconnect" );
    self notify( "playerCloseBuyStationMenu" );
    self endon( "playerCloseBuyStationMenu" );
    var0 = requestgamerprofiletimeout( "buystationCloseMenuOnPurchase", level.ë#5Ç9‡ﬁW*õ‚1ÿJ„«Ø4ù®≠w"q˚ÔMeEﬂ¥ );
    
    if ( !isdefined( var0 ) )
    {
        var0 = 1;
    }
    
    if ( var0 )
    {
        addtop3brcharge( 1 );
        return;
    }
}

// Params 2
// Size: 0x53
function requestgamerprofiletimeout( var0, var1 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "requestGamerProfileTimeout" + var0 );
    self setpredictedstreamloaddist( var0 );
    scripts\engine\utility::delaythread( var1, &scripts\engine\utility::send_notify, "requestGamerProfileTimeout" + var0 );
    
    for ( ;; )
    {
        self waittill( "luinotifyserver", var2, var3 );
        
        if ( var2 == "gamerprofile_request" )
        {
            return var3;
        }
    }
}

// Params 0
// Size: 0x34
function ref_125fd()
{
    var0 = self;
    level endon( "game_ended" );
    self endon( "disconnect" );
    var0 endon( "confirm_location" );
    scripts\engine\utility::waittill_any_ents( var0, "death", level, "game_ended" );
    var0 notify( "cancel_location" );
}

// Params 0
// Size: 0xda
function ref_125c1()
{
    self setclientomnvar( "ui_br_purchase_killstreak_response", 1 );
    self setclientomnvar( "ui_br_open_purchase_killstreak", 0 );
    self setclientomnvar( "ui_br_show_tac_map", 1 );
    scripts\cp_mp\utility\player_utility::_freezecontrols( 1, undefined, "kiosk" );
    self beginlocationselection( 0, 0, 0, 0, 4 );
    thread ref_125fd();
    var0 = scripts\mp\killstreaks\mapselect::waittill_confirm_or_cancel( "confirm_location", "cancel_location" );
    var1 = 0;
    self endlocationselection();
    
    if ( isdefined( var0 ) && var0.string == "confirm_location" )
    {
        if ( scripts\mp\gametypes\br_circle::vandalize_minigun_speed( var0.location, 1 ) )
        {
            var2 = scripts\mp\gametypes\br::ref_13c34( var0.location );
            var3 = var2[ "position" ];
            
            if ( scripts\mp\gametypes\br_circle::vandalize_minigun_speed( var3, 1 ) )
            {
                thread ref_12cbd( var3 );
                var1 = 1;
            }
            else
            {
                addtop3brcharge( 18 );
            }
        }
    }
    
    scripts\cp_mp\utility\player_utility::_freezecontrols( 0, 1, "kiosk" );
    self setclientomnvar( "ui_br_show_tac_map", 0 );
    return var1;
}

// Params 1
// Size: 0x17b
function ref_12cbd( var0 )
{
    level endon( "game_ended" );
    level notify( "restartCircleElimination" );
    var1 = 60;
    var2 = 4;
    var3 = -1;
    var4 = 15;
    var5 = getdvarint( "scr_br_late_circle_delay", var1 );
    var6 = getdvarint( "scr_br_late_circle_index", var2 );
    var7 = getdvarint( "scr_br_late_circle_close", var3 );
    var8 = getdvarint( "scr_br_late_circle_last", var4 );
    
    if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "restartCircleElimination" ) )
    {
        thread scripts\mp\gametypes\br_gametypes::ref_12e05( "restartCircleElimination", var0, var5 );
    }
    
    foreach ( var10 in level.players )
    {
        var10 scripts\mp\hud_message::showsplash( "br_late_circle_soon" );
    }
    
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "circle" ) )
    {
        scripts\mp\gametypes\br_circle::teleport_players_inside_subway_car( var0, var5, var6, var7 );
        level.disable_super_in_turret.lmg_guys[ "circle" ] = undefined;
    }
    
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params( "allowLateJoiners" ) )
    {
        level.allowlatecomers = 0;
        setnojiptime( 1, 1 );
        setnojipscore( 1, 1 );
    }
    
    var12 = max( 0, var5 - var8 );
    wait var12;
    
    foreach ( var10 in level.players )
    {
        var10 scripts\mp\hud_message::showsplash( "br_late_circle_now" );
    }
    
    var15 = var5 - var12;
    wait var15;
    
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "teamSpectate" ) )
    {
        level thread scripts\mp\gametypes\br_spectate::spectate_init();
        level.disable_super_in_turret.lmg_guys[ "teamSpectate" ] = undefined;
    }
    
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "oneLife" ) )
    {
        level.disablespawning = 1;
        setdynamicdvar( "scr_" + scripts\mp\utility\game::getgametype() + "_numLives", 1 );
        return;
    }
}

// Params 0
// Size: 0xfa
function ref_125c4()
{
    if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "playerHandleRedeploy" ) )
    {
        return scripts\mp\gametypes\br_gametypes::ref_12e05( "playerHandleRedeploy" );
    }
    
    self setclientomnvar( "ui_br_purchase_killstreak_response", 1 );
    self setclientomnvar( "ui_br_open_purchase_killstreak", 0 );
    self setclientomnvar( "ui_br_show_tac_map", 1 );
    scripts\cp_mp\utility\player_utility::_freezecontrols( 1, undefined, "kiosk" );
    self beginlocationselection( 0, 0, 0, 0, 4 );
    thread ref_125fd();
    var0 = scripts\mp\killstreaks\mapselect::waittill_confirm_or_cancel( "confirm_location", "cancel_location" );
    var1 = 0;
    self endlocationselection();
    
    if ( isdefined( var0 ) && var0.string == "confirm_location" )
    {
        if ( scripts\mp\gametypes\br_circle::vandalize_minigun_speed( var0.location, 1 ) )
        {
            var2 = scripts\mp\gametypes\br::ref_13c34( var0.location );
            var3 = var2[ "position" ];
            
            if ( scripts\mp\gametypes\br_circle::vandalize_minigun_speed( var3, 1 ) )
            {
                self notify( "_watchToAutoCloseMenu_end" );
                ref_12647( var3 );
                var1 = 1;
            }
            else
            {
                addtop3brcharge( 18 );
            }
        }
    }
    
    scripts\cp_mp\utility\player_utility::_freezecontrols( 0, 1, "kiosk" );
    self setclientomnvar( "ui_br_show_tac_map", 0 );
    return var1;
}

// Params 0
// Size: 0x45
function resetarenaomnvardata()
{
    var0 = 0;
    
    foreach ( var2 in level.br_armory_kiosk.scriptables )
    {
        if ( scripts\mp\gametypes\br_circle::ispointincurrentsafecircle( var2.origin ) )
        {
            var0++;
        }
    }
    
    return var0;
}

// Params 3
// Size: 0x19e
function ref_12647( var0, var1, var2 )
{
    var3 = self;
    level endon( "game_ended" );
    var3 endon( "disconnect" );
    var4 = 12000;
    var5 = var1;
    
    if ( !isdefined( var5 ) )
    {
        var5 = var4;
    }
    
    var6 = var2;
    
    if ( !isdefined( var6 ) )
    {
        var6 = 0;
    }
    
    var7 = spawnstruct();
    var7.origin = var0 + ( 0, 0, var5 );
    var7.angles = ( 0, var6, 0 );
    var7.height = var5;
    var8 = var3 scripts\mp\gametypes\br_gulag::ref_1263e( var7 );
    var3.forcespawnorigin = var8;
    var9 = 1;
    var3 scripts\mp\gametypes\br_gulag::gulagfadetoblack();
    wait var9;
    var10 = var7.origin;
    var11 = var7.angles;
    var12 = var10;
    
    if ( isdefined( var8 ) )
    {
        var12 = var8;
    }
    
    var3 scripts\mp\gametypes\br_gulag::set_scriptable_states();
    var3 scripts\mp\gametypes\br_gulag::ref_126c3( var12, var11 );
    var13 = spawn( "script_model", var12 );
    var13 setmodel( "tag_origin" );
    var13.angles = var11;
    var13 hide();
    var13 showtoplayer( var3 );
    var3 playerlinktoabsolute( var13, "tag_origin" );
    var3 playerhide();
    var3 thread scripts\mp\gametypes\br_gulag::ref_12524( var13 );
    waitframe();
    var3 scripts\mp\gametypes\br_public::ref_126ed();
    var3 scripts\mp\gametypes\br_public::ref_1252b();
    
    if ( isdefined( var8 ) )
    {
        var13.origin = var10;
    }
    
    var13 playsoundtoplayer( "br_ac130_flyby", var3 );
    wait 1.5;
    var3 unlink();
    var3 clearsoundsubmix( "deaths_door_mp" );
    var3 clearclienttriggeraudiozone( 1 );
    var3 playershow();
    var14 = 0;
    
    if ( isdefined( level.ref_121cc ) )
    {
        var14 = level.ref_121cc;
    }
    
    var3.use_armor = 1;
    var3 thread scripts\cp_mp\parachute::startfreefall( var14, 0, undefined, undefined, 1 );
    var3 setclientomnvar( "ui_br_transition_type", 0 );
    var3 setclientomnvar( "ui_show_spectateHud", -1 );
    var3 scripts\mp\gametypes\br_gulag::ref_12c7a();
    wait 0.5;
    var3 scripts\mp\gametypes\br_gulag::gulagfadefromblack();
    waitframe();
    var13 delete();
}

// Params 3
// Size: 0x1e
function callback_setscripteddiscountid( var0, var1, var2 )
{
    if ( isdefined( var0 ) )
    {
        _setplayerscripteddiscount( var0, var1, var2 );
        return;
    }
    
    _setlevelscripteddiscount( var1, var2 );
}

// Params 2
// Size: 0xd
function callback_getscripteddiscountid( var0, var1 )
{
    return _getscripteddiscountid( var0, var1 );
}

// Params 0
// Size: 0xe, Type: bool
function arescripteddiscountsenabled()
{
    return getdvarint( "scr_br_enable_hvv_discounts", 0 ) > 0;
}

// Params 0
// Size: 0x19
function applyscripteddiscounts()
{
    for ( var0 = 0; var0 < 3 ; var0++ )
    {
        _applyscripteddiscount( var0 );
    }
}

// Params 1
// Size: 0x2b
function getbestscripteddiscount( var0 )
{
    var1 = 0;
    
    for ( var2 = 0; var2 < 3 ; var2++ )
    {
        var3 = _getscripteddiscountvalue( var2, var0 );
        var1 = max( var1, var3 );
    }
    
    return var1;
}

// Params 1
// Size: 0x27
function _applyscripteddiscount( var0 )
{
    var1 = _getscripteddiscountid( var0 );
    var2 = 1 + var0 * 5;
    var3 = 5;
    ref_1260d( "ui_br_kiosk_ban_supply_drop", var1, var2, var3 );
}

// Params 2
// Size: 0x1d
function _setplayerscripteddiscount( var0, var1 )
{
    if ( !isdefined( self.¶çÊÿ9-‡é åKÕl∑∫Êé-#õ ) )
    {
        self.¶çÊÿ9-‡é åKÕl∑∫Êé-#õ = [];
    }
    
    self.¶çÊÿ9-‡é åKÕl∑∫Êé-#õ[ var0 ] = var1;
}

// Params 2
// Size: 0x30
function _setlevelscripteddiscount( var0, var1 )
{
    if ( !isdefined( level.disable_super_in_turret.¶çÊÿ9-‡é åKÕl∑∫Êé-#õ ) )
    {
        level.disable_super_in_turret.¶çÊÿ9-‡é åKÕl∑∫Êé-#õ = [];
    }
    
    level.disable_super_in_turret.¶çÊÿ9-‡é åKÕl∑∫Êé-#õ[ var0 ] = var1;
}

// Params 1
// Size: 0x51
function _getscripteddiscountid( var0 )
{
    if ( isdefined( self.¶çÊÿ9-‡é åKÕl∑∫Êé-#õ ) )
    {
        if ( isdefined( self.¶çÊÿ9-‡é åKÕl∑∫Êé-#õ[ var0 ] ) )
        {
            return self.¶çÊÿ9-‡é åKÕl∑∫Êé-#õ[ var0 ];
        }
    }
    
    if ( isdefined( level.disable_super_in_turret.¶çÊÿ9-‡é åKÕl∑∫Êé-#õ ) )
    {
        if ( isdefined( level.disable_super_in_turret.¶çÊÿ9-‡é åKÕl∑∫Êé-#õ[ var0 ] ) )
        {
            return level.disable_super_in_turret.¶çÊÿ9-‡é åKÕl∑∫Êé-#õ[ var0 ];
        }
    }
    
    return -1;
}

// Params 2
// Size: 0x30
function _getscripteddiscountvalue( var0, var1 )
{
    var2 = _isscripteddiscount( var0, var1 );
    
    if ( !var2 )
    {
        return 0;
    }
    
    if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "getScriptedDiscount" ) )
    {
        return scripts\mp\gametypes\br_gametypes::ref_12e05( "getScriptedDiscount", var0, var1 );
    }
    
    return 0;
}

// Params 2
// Size: 0x20, Type: bool
function _isscripteddiscount( var0, var1 )
{
    var2 = _getidfromref( var1 );
    var3 = _getscripteddiscountid( var0 );
    return var2 == var3 && var2 != -1;
}

// Params 1
// Size: 0x33
function _getidfromref( var0 )
{
    var1 = getdvar( "br_kiosk_items_filename", "mp/brKioskPurchases.csv" );
    
    if ( var1 == "" )
    {
        var1 = "mp/brKioskPurchases.csv";
    }
    
    return int( _vlookup( var1, 2, 0, var0, -1 ) );
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

// Params 4
// Size: 0x53
function ref_1260d( var0, var1, var2, var3 )
{
    if ( var1 == -1 )
    {
        var1 = ( 1 << var3 ) - 1;
    }
    
    var4 = int( pow( 2, var3 ) ) - 1;
    var5 = ( var1 & var4 ) << var2;
    var6 = ~( var4 << var2 );
    var7 = self calloutmarkerping_entityzoffset( var0 );
    var8 = var7 & var6;
    var9 = var8 + var5;
    
    if ( var9 != var7 )
    {
        self setclientomnvar( var0, var9 );
        return;
    }
}

