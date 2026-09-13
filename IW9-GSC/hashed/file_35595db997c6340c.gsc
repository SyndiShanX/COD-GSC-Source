/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_35595db997c6340c.gsc
***********************************************/

_id_47A79FC51AEB5823() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_techo", "initLate", ::_id_0E41728E3EFA537F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_techo", "create", ::_id_24D24CE92B8F9FED);
  scripts\engine\utility::create_func_ref("techo_rover", ::_id_60FC936DD3DE9B81);
}

_id_0E41728E3EFA537F() {
  if(1) {
    return;
  }
  _id_BFE291B401A9BF2A = scripts\engine\utility::getStructArray("techo_spawn", "targetname");
  thread _id_466912CE204E4051(_id_BFE291B401A9BF2A, 3);
}

_id_466912CE204E4051(_id_70DAB3207FB65169, delay) {
  wait(delay);
  _id_915E6307FD669235 = getdvarint("r_reflectionprobegenerate", 0) == 0;

  if(_id_915E6307FD669235) {
    foreach(struct in _id_70DAB3207FB65169) {
      spawndata = spawnStruct();
      spawndata.origin = struct.origin;
      spawndata.angles = struct.angles;
      vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_techo", spawndata);

      if(isDefined(vehicle))
        level._id_7D34D3DAD0A68D2F = scripts\engine\utility::array_add(level._id_7D34D3DAD0A68D2F, vehicle);
    }
  }
}

_id_24D24CE92B8F9FED(vehicle) {
  vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth(vehicle);
  vehicle.health = vehicle.maxhealth;
}

_id_60FC936DD3DE9B81(player) {
  spawndata = spawnStruct();
  spawndata.origin = player.origin + (0, 0, 100);
  spawndata.angles = player.angles * (0, 1, 0);
  spawndata.owner = player;
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_techo", spawndata);

  if(isDefined(vehicle))
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(vehicle, "driver", player, undefined, 1);
}