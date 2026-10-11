/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_228478d4175cb3b9.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp\vehicles\vehicle_oob_cp;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_mines;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;
#namespace namespace_6857f6e06c66d92c;

function function_7fbb4bdc170016b2() {
  registersharedfunc("veh9_suv_1996", "initLate", &function_4dd4f9b32d34b37e);
  registersharedfunc("veh9_suv_1996", "create", &function_f264518ea185294);
  create_func_ref("veh9_suv_1996", &function_701902185150632a);
}

function function_4dd4f9b32d34b37e() {
  if(true) {
    return;
  }

  level.var_907d3564338c8280 = [];
  spawnstructs = getStructArray("suv_1996_spawn", "targetname");
  thread function_5c3e799013e72b1a(spawnstructs, 3);
}

function function_5c3e799013e72b1a(structarray, delay) {
  wait delay;
  var_a3a86e2fdc8840d9 = getdvarint(@ "hash_e6afce2cf5cf7515", 0) == 0;

  if(var_a3a86e2fdc8840d9) {
    foreach(struct in structarray) {
      spawndata = spawnStruct();
      spawndata.origin = struct.origin;
      spawndata.angles = struct.angles;
      vehicle = vehicle_spawn("veh9_suv_1996", spawndata);

      if(isDefined(vehicle)) {
        level.var_907d3564338c8280 = array_add(level.var_907d3564338c8280, vehicle);
      }
    }
  }
}

function function_f264518ea185294(vehicle) {
  vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth(vehicle);
  vehicle.health = vehicle.maxhealth;
  vehicle.vehicle_specific_onentervehicle = &function_773ed31ffc2459df;
  vehicle.vehicle_specific_onexitvehicle = &function_b89e8c86f98d3697;
}

function function_701902185150632a(player) {
  spawndata = spawnStruct();
  spawndata.origin = player.origin + (0, 0, 100);
  spawndata.angles = player.angles * (0, 1, 0);
  spawndata.owner = player;
  vehicle = vehicle_spawn("veh9_suv_1996", spawndata);

  if(isDefined(vehicle)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(vehicle, "driver", player, undefined, 1);
  }
}

function function_773ed31ffc2459df(vehicle, newseatid, player, data) {
  player.isdrivingvehicle = 1;

  if(istrue(level.var_d39df167f3a996b0)) {
    vehicle setscriptablepartstate("lights", "on");
  }
}

function function_b89e8c86f98d3697(vehicle, newseatid, player, data) {
  if(!istrue(data.playerdisconnect)) {
    player.isdrivingvehicle = undefined;
  }

  if(istrue(level.var_d39df167f3a996b0)) {
    vehicle setscriptablepartstate("lights", "off");
  }
}