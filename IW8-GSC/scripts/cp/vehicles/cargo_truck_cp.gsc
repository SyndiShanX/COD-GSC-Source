/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\cargo_truck_cp.gsc
**************************************************/

function cargo_truck_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("cargo_truck", "initLate", &cargo_truck_cp_initlate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cargo_truck", "create", &cargo_truck_cp_create);
  scripts\engine\utility::create_func_ref("cargo_truck", &spawn_and_enter_cargo_truck);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cargo_truck", "spawnCallback", &cargo_truck_cp_spawncallback);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("cargo_truck", &scripts\cp_mp\vehicles\cargo_truck::cargo_truck_explode);
}

function cargo_truck_cp_initlate() {
  if(true) {
    return;
  }

  level.cargotrucks = [];
  var_0 = scripts\engine\utility::getStructArray("cargotruck_spawn", "targetname");
  thread cargo_truck_cp_createfromstructs(var_0, 3);
}

function cargo_truck_cp_createfromstructs(var_0, var_1) {
  wait var_1;
  var_2 = getdvarint("LLQQOPKTKM", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = scripts\cp_mp\vehicles\cargo_truck::cargo_truck_create(var_5);

      if(isDefined(var_6)) {
        level.cargotrucks = scripts\engine\utility::array_add(level.cargotrucks, var_6);
      }
    }

    return;
  }
}

function cargo_truck_cp_create(var_0) {
  var_0.maxhealth = 3500;
  var_0.health = var_0.maxhealth;
}

function spawn_and_enter_cargo_truck(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 100);
  var_1.angles = var_0.angles * (0, 1, 0);
  var_1.owner = var_0;
  var_2 = scripts\cp_mp\vehicles\cargo_truck::cargo_truck_create(var_1);

  if(isDefined(var_2)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, "driver", var_0, undefined, 1);
    return;
  }
}

function convert_aitruck_to_playertruck(var_0) {
  var_0 notify("death");
  var_0.vehiclename = "cargo_truck";
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

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck", "create")]](var_0);
  }

  return var_0;
}

function cargo_truck_cp_spawncallback(var_0, var_1) {
  if(true) {
    return;
  }

  var_2 = scripts\cp_mp\vehicles\cargo_truck::cargo_truck_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &cargo_truck_cp_ondeathrespawncallback;
  }

  return var_2;
}

function cargo_truck_cp_ondeathrespawncallback() {
  thread cargo_truck_cp_waitandspawn();
}

function cargo_truck_cp_waitandspawn() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("cargo_truck")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("cargo_truck", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }

      break;
    }
  }
}