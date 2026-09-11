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
  var0 = scripts\engine\utility::getStructArray("cargotruck_spawn", "targetname");
  thread cargo_truck_cp_createfromstructs(var0, 3);
}

function cargo_truck_cp_createfromstructs(var0, var1) {
  wait var1;
  var2 = getdvarint("LLQQOPKTKM", 0) == 0;

  if(var2) {
    foreach(var4 in var0) {
      var5 = spawnStruct();
      var5.origin = var4.origin;
      var5.angles = var4.angles;
      var6 = scripts\cp_mp\vehicles\cargo_truck::cargo_truck_create(var5);

      if(isDefined(var6)) {
        level.cargotrucks = scripts\engine\utility::array_add(level.cargotrucks, var6);
      }
    }

    return;
  }
}

function cargo_truck_cp_create(var0) {
  var0.maxhealth = 3500;
  var0.health = var0.maxhealth;
}

function spawn_and_enter_cargo_truck(var0) {
  var1 = spawnStruct();
  var1.origin = var0.origin + (0, 0, 100);
  var1.angles = var0.angles * (0, 1, 0);
  var1.owner = var0;
  var2 = scripts\cp_mp\vehicles\cargo_truck::cargo_truck_create(var1);

  if(isDefined(var2)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var2, "driver", var0, undefined, 1);
    return;
  }
}

function convert_aitruck_to_playertruck(var0) {
  var0 notify("death");
  var0.vehiclename = "cargo_truck";
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

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck", "create")]](var0);
  }

  return var0;
}

function cargo_truck_cp_spawncallback(var0, var1) {
  if(true) {
    return;
  }

  var2 = scripts\cp_mp\vehicles\cargo_truck::cargo_truck_create(var0, var1);

  if(isDefined(var2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &cargo_truck_cp_ondeathrespawncallback;
  }

  return var2;
}

function cargo_truck_cp_ondeathrespawncallback() {
  thread cargo_truck_cp_waitandspawn();
}

function cargo_truck_cp_waitandspawn() {
  var0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var0);
  var1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("cargo_truck")) {
      var2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("cargo_truck", var0, var1);

      if(!isDefined(var2)) {
        continue;
      }

      break;
    }
  }
}