/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\tac_rover_cp.gsc
************************************************/

tac_rover_cp_init() {
  scripts\engine\utility::create_func_ref("tac_rover", ::spawn_and_enter_tac_rover);
  scripts\cp_mp\utility\script_utility::registersharedfunc("tac_rover", "initLate", ::tac_rover_cp_initlate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("tac_rover", "create", ::tac_rover_cp_create);
}

tac_rover_cp_initlate() {
  if(1) {
    return;
  }
  _id_BFE291B401A9BF2A = scripts\engine\utility::getStructArray("tacrover_spawn", "targetname");
  thread tac_rover_cp_createfromstructs(_id_BFE291B401A9BF2A, 3);
}

tac_rover_cp_createfromstructs(_id_70DAB3207FB65169, delay) {
  wait(delay);
  _id_915E6307FD669235 = getdvarint("r_reflectionprobegenerate", 0) == 0;

  if(_id_915E6307FD669235) {
    foreach(struct in _id_70DAB3207FB65169) {
      spawndata = spawnStruct();
      spawndata.origin = struct.origin;
      spawndata.angles = struct.angles;
      vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("tac_rover", spawndata);

      if(isDefined(vehicle))
        level.tacrovers = scripts\engine\utility::array_add(level.tacrovers, vehicle);
    }
  }
}

tac_rover_cp_create(vehicle) {
  vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth(vehicle);
  vehicle.health = vehicle.maxhealth;
}

spawn_and_enter_tac_rover(player) {
  spawndata = spawnStruct();
  spawndata.origin = player.origin + (0, 0, 100);
  spawndata.angles = player.angles * (0, 1, 0);
  spawndata.owner = player;
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("tac_rover", spawndata);

  if(isDefined(vehicle))
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(vehicle, "driver", player, undefined, 1);
}