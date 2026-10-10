/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_3bdd48aafc976300.gsc
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
#namespace namespace_8c61fd538bb78da5;

function function_6e5970ec1a994b0b() {
  registersharedfunc("veh9_patrol_boat", "initLate", &function_85b82db0a7c98677);
  registersharedfunc("veh9_patrol_boat", "create", &function_6a80f5460ac9e725);
  create_func_ref("patrol_boat", &function_57fd1bcc7d1ae375);
}

function function_85b82db0a7c98677() {
  if(true) {
    return;
  }

  spawnstructs = getStructArray("patrol_boat_spawn", "targetname");
  thread function_f41c505f96a5f7f9(spawnstructs, 3);
}

function function_f41c505f96a5f7f9(structarray, delay) {
  wait delay;
  canspawnvehicles = getdvarint(@ "hash_e6afce2cf5cf7515", 0) == 0;

  if(canspawnvehicles) {
    foreach(struct in structarray) {
      spawndata = spawnStruct();
      spawndata.origin = struct.origin;
      spawndata.angles = struct.angles;
      vehicle = vehicle_spawn("veh9_patrol_boat", spawndata);

      if(isDefined(vehicle)) {
        level.var_9ab8e1fae12997d7 = array_add(level.var_9ab8e1fae12997d7, vehicle);
      }
    }
  }
}

function function_6a80f5460ac9e725(vehicle) {
  vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth(vehicle);
  vehicle.health = vehicle.maxhealth;
}

function function_57fd1bcc7d1ae375(player) {
  spawndata = spawnStruct();
  spawndata.origin = player.origin + (0, 0, 100);
  spawndata.angles = player.angles * (0, 1, 0);
  spawndata.owner = player;
  vehicle = vehicle_spawn("veh9_patrol_boat", spawndata);

  if(isDefined(vehicle)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(vehicle, "driver", player, undefined, 1);
  }
}