/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58211.gsc
***********************************************/

function get_most_recent_ping() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("cargo_truck_susp_aa", "initLate", &get_moves_till_stop);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cargo_truck_susp_aa", "create", &get_most_recent_danger_ping);
  scripts\engine\utility::create_func_ref("cargo_truck_susp_aa", &ref_134f8);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cargo_truck_susp_aa", "spawnCallback", &get_nearest_point_near_objective);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("cargo_truck_susp_aa", &_calloutmarkerping_iskiosk::get_num_dogtag_in_kill_zone_or_under_bridge_zone);
}

function get_moves_till_stop() {
  if(true) {
    return;
  }

  level.get_reinforcement_icon_image = [];
  var_0 = scripts\engine\utility::getStructArray("cargotrucksuspaa_spawn", "targetname");
  thread get_most_recent_location_ping(var_0, 3);
}

function get_most_recent_location_ping(var_0, var_1) {
  wait var_1;
  var_2 = getdvarint("LLQQOPKTKM", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = _calloutmarkerping_iskiosk::get_next_available_wire_for_bomb(var_5);

      if(isDefined(var_6)) {
        level.get_reinforcement_icon_image = scripts\engine\utility::array_add(level.get_reinforcement_icon_image, var_6);
      }
    }

    return;
  }
}

function get_most_recent_danger_ping(var_0) {
  var_0.maxhealth = 2300;
  var_0.health = var_0.maxhealth;
}

function ref_134f8(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 100);
  var_1.angles = var_0.angles * (0, 1, 0);
  var_1.owner = var_0;
  var_2 = _calloutmarkerping_iskiosk::get_next_available_wire_for_bomb(var_1);

  if(isDefined(var_2)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, "driver", var_0, undefined, 1);
    return;
  }
}

function convert_aitruck_to_playertruck(var_0) {
  var_0 notify("death");
  var_0.vehiclename = "cargo_truck_susp_aa";
  var_0.maxhealth = 999999;
  var_0.health = var_0.maxhealth;
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(var_0, "neutral");
  var_0.objweapon = getcompleteweaponname("cargo_truck_mp");
  var_0 makeunusable();
  var_0 setCanDamage(1);
  var_0 scripts\cp_mp\emp_debuff::set_start_emp_callback(&scripts\cp_mp\vehicles\vehicle::vehicle_empstartcallback);
  var_0 scripts\cp_mp\emp_debuff::set_clear_emp_callback(&scripts\cp_mp\vehicles\vehicle::vehicle_empclearcallback);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_registerinstance(var_0);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_registerinstance(var_0);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(var_0);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(var_0, undefined, undefined);
  scripts\cp_mp\vehicles\vehicle_dlog::vehicle_dlog_spawnevent(var_0, undefined);
  var_1 = &scripts\cp_mp\utility\weapon_utility::setlockedoncallback;
  [[var_1]](var_0, &scripts\cp_mp\vehicles\vehicle::vehicle_lockedoncallback);
  var_2 = &scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback;
  [[var_2]](var_0, &scripts\cp_mp\vehicles\vehicle::vehicle_lockedonremovedcallback);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_0, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck_susp_aa", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck_susp_aa", "create")]](var_0);
  }

  return var_0;
}

function get_nearest_point_near_objective(var_0, var_1) {
  if(true) {
    return;
  }

  var_2 = _calloutmarkerping_iskiosk::get_next_available_wire_for_bomb(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &get_nearby_enemy_in_tvstation;
  }

  return var_2;
}

function get_nearby_enemy_in_tvstation() {
  thread get_new_wire_look_at_marker_currently_looking_at();
}

function get_new_wire_look_at_marker_currently_looking_at() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("cargo_truck_susp_aa")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("cargo_truck_susp_aa", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }

      break;
    }
  }
}