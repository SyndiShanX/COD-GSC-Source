/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_35595db997c6340c.gsc
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
#namespace namespace_3723c659cb1de901;

function function_47a79fc51aeb5823() {
  registersharedfunc("veh9_techo", "initLate", &function_e41728e3efa537f);
  registersharedfunc("veh9_techo", "create", &function_24d24ce92b8f9fed);
  create_func_ref("techo_rover", &function_60fc936dd3de9b81);
}

function function_e41728e3efa537f() {
  if(true) {
    return;
  }

  spawnstructs = getStructArray("techo_spawn", "targetname");
  thread function_466912ce204e4051(spawnstructs, 3);
}

function function_466912ce204e4051(structarray, delay) {
  wait delay;
  canspawnvehicles = getdvarint(@ "hash_e6afce2cf5cf7515", 0) == 0;

  if(canspawnvehicles) {
    foreach(struct in structarray) {
      spawndata = spawnStruct();
      spawndata.origin = struct.origin;
      spawndata.angles = struct.angles;
      vehicle = vehicle_spawn("veh9_techo", spawndata);

      if(isDefined(vehicle)) {
        level.var_7d34d3dad0a68d2f = array_add(level.var_7d34d3dad0a68d2f, vehicle);
      }
    }
  }
}

function function_24d24ce92b8f9fed(vehicle) {
  vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth(vehicle);
  vehicle.health = vehicle.maxhealth;
}

function function_60fc936dd3de9b81(player) {
  spawndata = spawnStruct();
  spawndata.origin = player.origin + (0, 0, 100);
  spawndata.angles = player.angles * (0, 1, 0);
  spawndata.owner = player;
  vehicle = vehicle_spawn("veh9_techo", spawndata);

  if(isDefined(vehicle)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(vehicle, "driver", player, undefined, 1);
  }
}