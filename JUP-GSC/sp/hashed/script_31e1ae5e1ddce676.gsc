/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_31e1ae5e1ddce676.gsc
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
#namespace namespace_c1f1eb97c978bfbb;

function function_f8cd879642397a71() {
  registersharedfunc("veh9_sedan_hatchback_1985", "initLate", &function_155de152ad763cf5);
  registersharedfunc("veh9_sedan_hatchback_1985", "create", &function_54d66e9828e8498f);
  create_func_ref("veh9_sedan_hatchback_1985", &function_701902185150632a);
}

function function_155de152ad763cf5() {
  if(true) {
    return;
  }

  level.var_907d3564338c8280 = [];
  spawnstructs = getStructArray("sedan_hatchback_1985_spawn", "targetname");
  thread function_f0918a0308e39dfb(spawnstructs, 3);
}

function function_f0918a0308e39dfb(structarray, delay) {
  wait delay;
  var_a3a86e2fdc8840d9 = getdvarint(@ "hash_e6afce2cf5cf7515", 0) == 0;

  if(var_a3a86e2fdc8840d9) {
    foreach(struct in structarray) {
      spawndata = spawnStruct();
      spawndata.origin = struct.origin;
      spawndata.angles = struct.angles;
      vehicle = vehicle_spawn("veh9_sedan_hatchback_1985", spawndata);

      if(isDefined(vehicle)) {
        level.var_907d3564338c8280 = array_add(level.var_907d3564338c8280, vehicle);
      }
    }
  }
}

function function_54d66e9828e8498f(vehicle) {
  vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth(vehicle);
  vehicle.health = vehicle.maxhealth;
  vehicle.vehicle_specific_onentervehicle = &function_7df76584d6078b46;
  vehicle.vehicle_specific_onexitvehicle = &function_40ce047405104c04;
}

function function_701902185150632a(player) {
  spawndata = spawnStruct();
  spawndata.origin = player.origin + (0, 0, 100);
  spawndata.angles = player.angles * (0, 1, 0);
  spawndata.owner = player;
  vehicle = vehicle_spawn("veh9_sedan_hatchback_1985", spawndata);

  if(isDefined(vehicle)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(vehicle, "driver", player, undefined, 1);
  }
}

function function_7df76584d6078b46(vehicle, var_7558f98f3236963d, player, data) {
  player.isdrivingvehicle = 1;

  if(istrue(level.var_d39df167f3a996b0)) {
    vehicle setscriptablepartstate("tag_light_front_left", "on");
    vehicle setscriptablepartstate("tag_light_front_right", "on");
    vehicle setscriptablepartstate("tag_light_back_left", "on");
    vehicle setscriptablepartstate("tag_light_back_right", "on");
  }
}

function function_40ce047405104c04(vehicle, var_7558f98f3236963d, player, data) {
  if(!istrue(data.playerdisconnect)) {
    player.isdrivingvehicle = undefined;
  }

  if(istrue(level.var_d39df167f3a996b0)) {
    vehicle setscriptablepartstate("tag_light_front_left", "off");
    vehicle setscriptablepartstate("tag_light_front_right", "off");
    vehicle setscriptablepartstate("tag_light_back_left", "off");
    vehicle setscriptablepartstate("tag_light_back_right", "off");
  }
}