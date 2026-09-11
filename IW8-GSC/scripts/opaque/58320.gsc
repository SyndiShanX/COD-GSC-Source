
// Params 0
// Size: 0x10f
function create_vehicle_interact()
{
    scripts\cp_mp\utility\script_utility::registersharedfunc( "veh_bt", "spawnCallback", &create_weapon_pick_up );
    create_vehicle_omnvars_data();
    create_vehicle_occupancy_data();
    scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback( "veh_bt", &_calloutmarkerping_handleluinotify_mappingdeletemarker::create_script_wait_for_flags );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "veh_bt", "endEnterInternal", &create_vault_assault_loadout_selection );
    level.resttimems = &scripts\mp\utility\player::getplayersinradius;
    level.little_bird_mg_mp_initspawning = &scripts\mp\gametypes\br_armory_kiosk::little_bird_mg_mp_initmines;
    level.•Êk»Økp©ÁCùW
‚è~Ìà°õ@}GHÎ = &scripts\mp\gametypes\br_armory_trader::little_bird_mg_mp_ondeathrespawncallback;
    level.ref_13352 = &scripts\mp\hud_message::showerrormessage;
    level.ref_11a22 = &scripts\mp\gametypes\br_pickups::ref_11a21;
    level.crossbowusageloop = &scripts\mp\rank::giverankxp;
    level.ctgs_recordmatchstats = &scripts\mp\rank::scoreeventpopup;
    level.cumulative_damage_monitor = &scripts\mp\hud_message::showsplash;
    level.createpropspeclist = &scripts\mp\utility\player::unset_relic_trex;
    level.cruisepredator_assigntargetmarkers = &scripts\mp\utility\perk::_hasperk;
    level.ctf_bot_attacker_limit_for_team = &scripts\mp\gametypes\br_public::isplayeringulag;
    level.cruise_predator_direction_override = &scripts\mp\utility\points::sec_sys_struct_1;
    level.createpropspecatehud = &scripts\mp\gametypes\br_gametype_dmz::get_unique_id;
    level.crossbowbolts = &scripts\mp\gametypes\br_quest_util::getquestdata;
    level.crossbow = &scripts\mp\gametypes\br_timedrun_quest::pattern;
    level.critical_messages = &scripts\mp\gametypes\br_gulag::gulagfadetoblack;
    level.createzombieloadout = &scripts\mp\gametypes\br_gulag::gulagfadefromblack;
    level.createquestcircle = &scripts\mp\gametypes\br_armory_kiosk::addtop3brcharge;
    level.cumulative_damage_to_chopper_boss = &scripts\mp\gametypes\br_skyhook::chopperexfil_sh050_start;
    level.crossbowimpactwatcher = &scripts\mp\utility\teams::getteamdata;
    level.createplayerplundereventdata = &scripts\mp\gametypes\br_public::brleaderdialog;
    level.failsafe_triggered = getdvarint( "scr_bt_allow_bomber_respawn", 1 );
}

// Params 0
// Size: 0x42
function create_vehicle_omnvars_data()
{
    var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle( "veh_bt", 1 );
    var0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
    var0.areplayersnear = 60;
    var1 = getdvarfloat( "scr_bt_respawn_delay", 100 );
    
    if ( var1 >= 0 )
    {
        var0.ref_12ca1 = var1;
        return;
    }
}

// Params 0
// Size: 0x61
function create_vehicle_occupancy_data()
{
    var0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle( "veh_bt", 1 );
    var0.frontextents = 165;
    var0.backextents = 168;
    var0.leftextents = 57;
    var0.rightextents = 57;
    var0.bottomextents = 35;
    var0.distancetobottom = 50;
    var0.loscheckoffset = ( 0, 0, 70 );
}

// Params 2
// Size: 0x4b
function create_weapon_pick_up( var0, var1 )
{
    var2 = _calloutmarkerping_handleluinotify_mappingdeletemarker::create_mp_version_of_vehicle( var0, var1 );
    var3 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle( "veh_bt" );
    var4 = isdefined( var3 ) && isdefined( var3.ref_12ca1 );
    
    if ( isdefined( var2 ) && ( istrue( level.failsafe_triggered ) || var4 ) )
    {
        var2.ondeathrespawn = &create_vehicle_vehicledata;
    }
    
    return var2;
}

// Params 0
// Size: 0x8
function create_vehicle_vehicledata()
{
    thread create_weapon_pick_ups();
}

// Params 0
// Size: 0x48
function create_weapon_pick_ups()
{
    var0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata( self );
    var1 = spawnstruct();
    scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata( var0, var1 );
    var1.ref = var0.ref;
    var1.rallypointhealth = var0.rallypointhealth;
    var2 = spawnstruct();
    var3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421c( "veh_bt", var1, var2 );
}

// Params 5
// Size: 0x16
function create_vault_assault_loadout_selection( var0, var1, var2, var3, var4 )
{
    var0 scripts\mp\gametypes\arm::ref_141ff( var3.team );
}

