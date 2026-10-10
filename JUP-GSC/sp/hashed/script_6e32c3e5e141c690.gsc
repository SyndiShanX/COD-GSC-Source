/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_6e32c3e5e141c690.gsc
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
#namespace namespace_cbbca44aa26ee855;

function function_944a2eb36063f641() {
  level.var_3b897e0bf2fd1085 = [];
  registersharedfunc("veh9_rhib", "initLate", &function_579a147ed98230e5);
  registersharedfunc("veh9_rhib", "create", &function_8278682e1f6a45bf);
  create_func_ref("rhib", &function_60df0d6dd51d625);
}

function function_579a147ed98230e5() {
  spawnstructs = getStructArray("rhib_spawn", "targetname");

  if(!function_6d4917219f632ba7()) {
    return;
  }

  thread function_a5f198848c9214ab(spawnstructs, 3);
}

function function_a5f198848c9214ab(structarray, delay) {
  wait delay;
  canspawnvehicles = getdvarint(@ "hash_e6afce2cf5cf7515", 0) == 0;

  if(canspawnvehicles) {
    foreach(struct in structarray) {
      spawndata = spawnStruct();
      spawndata.origin = struct.origin;
      spawndata.angles = struct.angles;
      vehicle = vehicle_spawn("veh9_rhib", spawndata);

      if(isDefined(vehicle)) {
        level.var_3b897e0bf2fd1085 = array_add(level.var_3b897e0bf2fd1085, vehicle);
      }
    }
  }
}

function function_8278682e1f6a45bf(vehicle) {
  vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth(vehicle);
  vehicle.health = vehicle.maxhealth;
}

function function_60df0d6dd51d625(player) {
  spawndata = spawnStruct();
  spawndata.origin = player.origin + (0, 0, 100);
  spawndata.angles = player.angles * (0, 1, 0);
  spawndata.owner = player;
  vehicle = vehicle_spawn("veh9_rhib", spawndata);

  if(isDefined(vehicle)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(vehicle, "driver", player, undefined, 1);
  }
}

function function_6d4917219f632ba7() {
  return istrue(level.var_a81f53987e0482bf);
}