/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\apc_rus_cp.gsc
***********************************************/

apc_rus_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("apc_russian", "initLate", ::apc_rus_cp_initlate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("apc_russian", "create", ::apc_rus_cp_create);
  scripts\engine\utility::create_func_ref("apc_russian", ::spawn_and_enter_apc_rus);
}

apc_rus_cp_initlate() {
  if(1) {
    return;
  }
  level.apcsrus = [];
  _id_BFE291B401A9BF2A = scripts\engine\utility::getStructArray("apcrussian_spawn", "targetname");
  thread apc_rus_cp_createfromstructs(_id_BFE291B401A9BF2A, 3);
}

apc_rus_cp_createfromstructs(_id_70DAB3207FB65169, delay) {
  wait(delay);
  _id_915E6307FD669235 = getdvarint("r_reflectionprobegenerate", 0) == 0;

  if(_id_915E6307FD669235) {
    foreach(struct in _id_70DAB3207FB65169) {
      spawndata = spawnStruct();
      spawndata.origin = struct.origin;
      spawndata.angles = struct.angles;
      vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("apc_russian", spawndata);

      if(isDefined(vehicle))
        level.apcsrus = scripts\engine\utility::array_add(level.apcsrus, vehicle);
    }
  }
}

apc_rus_cp_create(vehicle) {
  vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth(vehicle);
  vehicle.health = vehicle.maxhealth;
}

spawn_and_enter_apc_rus(player) {
  spawndata = spawnStruct();
  spawndata.origin = player.origin + (0, 0, 100);
  spawndata.angles = player.angles * (0, 1, 0);
  spawndata.owner = player;
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("apc_russian", spawndata);

  if(isDefined(vehicle))
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(vehicle, "driver", player, undefined, 1);
}