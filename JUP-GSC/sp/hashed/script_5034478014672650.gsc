/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_5034478014672650.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp\vehicles\vehicle_oob_cp;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_dlog;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_mines;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;
#namespace namespace_71830b73b9607195;

function function_335dd1c457c3a367() {
  registersharedfunc("veh9_mkilo23", "initLate", &function_f9555f89314d822b);
  registersharedfunc("veh9_mkilo23", "create", &function_80c77207370f69c9);
  create_func_ref("veh9_mkilo23", &function_c1e08166e5f36e65);
}

function function_f9555f89314d822b() {
  if(true) {
    return;
  }

  level.var_7f12e5f545dfe91b = [];
  spawnstructs = getStructArray("mkilo23_spawn", "targetname");
  thread function_da744536b72b0f35(spawnstructs, 3);
}

function function_da744536b72b0f35(structarray, delay) {
  wait delay;
  var_143ec77a5546a43a = getdvarint(@ "hash_e6afce2cf5cf7515", 0) == 0;

  if(var_143ec77a5546a43a) {
    foreach(struct in structarray) {
      spawndata = spawnStruct();
      spawndata.origin = struct.origin;
      spawndata.angles = struct.angles;
      vehicle = vehicle_spawn("veh9_mkilo23", spawndata);

      if(isDefined(vehicle)) {
        level.var_7f12e5f545dfe91b = array_add(level.var_7f12e5f545dfe91b, vehicle);
      }
    }
  }
}

function function_80c77207370f69c9(vehicle) {
  vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth(vehicle);
  vehicle.health = vehicle.maxhealth;
}

function function_c1e08166e5f36e65(player) {
  spawndata = spawnStruct();
  spawndata.origin = player.origin + (0, 0, 100);
  spawndata.angles = player.angles * (0, 1, 0);
  spawndata.owner = player;
  vehicle = vehicle_spawn("veh9_mkilo23", spawndata);

  if(isDefined(vehicle)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(vehicle, "driver", player, undefined, 1);
  }
}

function convert_aitruck_to_playertruck(vehicle) {
  vehicle notify("death");
  vehicle.vehiclename = "veh9_mkilo23";
  vehicle.maxhealth = 999999;
  vehicle.health = vehicle.maxhealth;
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(vehicle, "neutral");
  vehicle.objweapon = makeweapon(function_7aaa7ae503292f43("veh9_mkilo23"));
  vehicle makeunusable();
  vehicle setCanDamage(1);
  vehicle scripts\cp_mp\emp_debuff::set_start_emp_callback(&scripts\cp_mp\vehicles\vehicle::vehicle_empstartcallback);
  vehicle scripts\cp_mp\emp_debuff::set_clear_emp_callback(&scripts\cp_mp\vehicles\vehicle::vehicle_empclearcallback);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_registerinstance(vehicle);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_registerinstance(vehicle);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(vehicle);
  vehicle_tracking_registerinstance(vehicle, undefined, undefined);
  scripts\cp_mp\vehicles\vehicle_dlog::vehicle_dlog_spawnevent(vehicle, undefined);
  var_e9ad534890b3b83e = &scripts\cp_mp\utility\weapon_utility::setlockedoncallback;
  [[var_e9ad534890b3b83e]](vehicle, &scripts\cp_mp\vehicles\vehicle::vehicle_lockedoncallback);
  var_cfde26882efc85e = &scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback;
  [[var_cfde26882efc85e]](vehicle, &scripts\cp_mp\vehicles\vehicle::vehicle_lockedonremovedcallback);
  vehicle thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped();

  if(issharedfuncdefined("veh9_mkilo23", "create")) {
    [[getsharedfunc("veh9_mkilo23", "create")]](vehicle);
  }

  return vehicle;
}