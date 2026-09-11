/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58212.gsc
***********************************************/

function get_player_velo_array() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("cargo_truck_susp", "initLate", &get_player_who_most_likely_broke_stealth);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cargo_truck_susp", "create", &get_player_planting_zone);
  scripts\engine\utility::create_func_ref("cargo_truck_susp", &ref_134f7);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cargo_truck_susp", "spawnCallback", &get_player_who_most_recently_threw_grenade);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("cargo_truck_susp", &_calloutmarkerping_isenemy::get_power_ref_from_weapon);
}

function get_player_who_most_likely_broke_stealth() {
  if(true) {
    return;
  }

  level.get_reinforcement_icon_image = [];
  var0 = scripts\engine\utility::getStructArray("cargotrucksusp_spawn", "targetname");
  thread get_player_recent_pos_adjusted_with_exposure(var0, 3);
}

function get_player_recent_pos_adjusted_with_exposure(var0, var1) {
  wait var1;
  var2 = getdvarint("LLQQOPKTKM", 0) == 0;

  if(var2) {
    foreach(var4 in var0) {
      var5 = spawnStruct();
      var5.origin = var4.origin;
      var5.angles = var4.angles;
      var6 = _calloutmarkerping_isenemy::get_players_in_mortar_range(var5);

      if(isDefined(var6)) {
        level.get_reinforcement_icon_image = scripts\engine\utility::array_add(level.get_reinforcement_icon_image, var6);
      }
    }

    return;
  }
}

function get_player_planting_zone(var0) {
  var0.maxhealth = 2300;
  var0.health = var0.maxhealth;
}

function ref_134f7(var0) {
  var1 = spawnStruct();
  var1.origin = var0.origin + (0, 0, 100);
  var1.angles = var0.angles * (0, 1, 0);
  var1.owner = var0;
  var2 = _calloutmarkerping_isenemy::get_players_in_mortar_range(var1);

  if(isDefined(var2)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var2, "driver", var0, undefined, 1);
    return;
  }
}

function convert_aitruck_to_playertruck(var0) {
  var0 notify("death");
  var0.vehiclename = "cargo_truck_susp";
  var0.maxhealth = 999999;
  var0.health = var0.maxhealth;
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(var0, "neutral");
  var0.objweapon = getcompleteweaponname("cargo_truck_mp");
  var0 makeunusable();
  var0 setCanDamage(1);
  var0 scripts\cp_mp\emp_debuff::set_start_emp_callback(&scripts\cp_mp\vehicles\vehicle::vehicle_empstartcallback);
  var0 scripts\cp_mp\emp_debuff::set_clear_emp_callback(&scripts\cp_mp\vehicles\vehicle::vehicle_empclearcallback);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_registerinstance(var0);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_registerinstance(var0);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(var0);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(var0, undefined, undefined);
  scripts\cp_mp\vehicles\vehicle_dlog::vehicle_dlog_spawnevent(var0, undefined);
  var1 = &scripts\cp_mp\utility\weapon_utility::setlockedoncallback;
  [[var1]](var0, &scripts\cp_mp\vehicles\vehicle::vehicle_lockedoncallback);
  var2 = &scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback;
  [[var2]](var0, &scripts\cp_mp\vehicles\vehicle::vehicle_lockedonremovedcallback);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var0, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck_susp", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck_susp", "create")]](var0);
  }

  return var0;
}

function get_player_who_most_recently_threw_grenade(var0, var1) {
  if(true) {
    return;
  }

  var2 = _calloutmarkerping_isenemy::get_players_in_mortar_range(var0, var1);

  if(isDefined(var2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &get_player_who_most_recently_fired_weapon;
  }

  return var2;
}

function get_player_who_most_recently_fired_weapon() {
  thread get_players_at_zone();
}

function get_players_at_zone() {
  var0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var0);
  var1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("cargo_truck_susp")) {
      var2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("cargo_truck_susp", var0, var1);

      if(!isDefined(var2)) {
        continue;
      }

      break;
    }
  }
}