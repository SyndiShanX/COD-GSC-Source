/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\vehicle_mp.gsc
***********************************************/

function vehicle_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "create", &ref_141bf);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "createLate", &ref_141c0);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "deleteNextFrame", &ref_141c1);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "deleteNextFrameLate", &ref_141c2);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "hide", &ref_141c3);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_interact", "init", &scripts\mp\vehicles\vehicle_interact_mp::vehicle_interact_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "init", &scripts\mp\vehicles\vehicle_occupancy_mp::vehicle_occupancy_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_mines", "init", &scripts\mp\vehicles\vehicle_mines_mp::vehicle_mines_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_spawn", "init", &scripts\mp\vehicles\vehicle_spawn_mp::vehicle_spawn_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_compass", "init", &abandonedtimeoutcallback::ref_14127);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "init", &abandonedtimeoutdelay::ref_14161);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_upgrade", "init", &scripts\mp\gametypes\br_armory_kiosk::_runpurchasemenu);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_trophy", "init", &scripts\mp\equipment\trophy_system::trophy_watchprotection);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_trophyDestroyTarget", "init", &scripts\mp\equipment\trophy_system::ref_13dd6);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_trophyCreateExplosion", "init", &scripts\mp\equipment\trophy_system::trophy_createexplosion);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_trophyExplode", "init", &scripts\mp\equipment\trophy_system::trophy_explode);
  scripts\cp_mp\utility\script_utility::registersharedfunc("technical", "init", &scripts\mp\vehicles\technical_mp::technical_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "init", &scripts\mp\vehicles\light_tank_mp::light_tank_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("little_bird", "init", &scripts\mp\vehicles\little_bird_mp::little_bird_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("little_bird_mg", "init", &_x1opsnpcwaittilluse::xpperweapon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("tac_rover", "init", &scripts\mp\vehicles\tac_rover_mp::tac_rover_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("atv", "init", &scripts\mp\vehicles\atv_mp::atv_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("large_transport", "init", &scripts\mp\vehicles\large_transport_mp::large_transport_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cop_car", "init", &scripts\mp\vehicles\cop_car_mp::cop_car_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pickup_truck", "init", &scripts\mp\vehicles\pickup_truck_mp::pickup_truck_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cargo_truck", "init", &scripts\mp\vehicles\cargo_truck_mp::cargo_truck_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cargo_truck_mg", "init", &_waitforlui::get_last_stand_id);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hoopty", "init", &scripts\mp\vehicles\hoopty_mp::hoopty_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("jeep", "init", &scripts\mp\vehicles\jeep_mp::jeep_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("medium_transport", "init", &scripts\mp\vehicles\med_transport_mp::med_transport_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hoopty_truck", "init", &scripts\mp\vehicles\hoopty_truck_mp::hoopty_truck_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("van", "init", &scripts\mp\vehicles\van_mp::van_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("apc_russian", "init", &scripts\mp\vehicles\apc_rus_mp::apc_rus_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("motorcycle", "init", &_x1opsplayerredactalltacmaplocation::ref_11d6a);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh_a10fd", "init", &_x1opsassignnpctoteam::bot_item_matches_purpose);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh_bt", "init", &_validateitempurchase::create_vehicle_interact);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh_indigo", "init", &_x1opsnpcpulsecheckteamnearby::startdisabled);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cargo_truck_susp", "init", &_watchtoautoclosemenu::get_random_primary_weapon_obj);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cargo_truck_susp_aa", "init", &_watchforcircleclosure::get_player_aggro_score);
  scripts\cp_mp\utility\script_utility::registersharedfunc("open_jeep", "init", &_x1opsunassignnpcfromteam::ref_1210b);
  scripts\cp_mp\utility\script_utility::registersharedfunc("open_jeep_carpoc", "init", &_x1opsplayerunredacttacmaplocation::ref_120dc);
  scripts\mp\vehicles\damage::init();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_init();
}

function ref_141bf(var_0, var_1) {
  var_0.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::ref_1414e(var_0);
  var_0.health = var_0.maxhealth;
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registerinstance(var_0);
  var_0 enableplayermarks("killstreak");
  scripts\mp\vehicles\vehicle_occupancy_mp::vehicle_occupancy_mp_updatemarkfilter(var_0);
}

function ref_141c0(var_0, var_1) {}

function ref_141c1(var_0) {
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_clearoob(var_0, 1);
}

function ref_141c2(var_0) {}

function ref_141c3(var_0) {}