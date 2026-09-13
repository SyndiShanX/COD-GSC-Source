/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3bdd48aafc976300.gsc
***********************************************/

_id_6E5970EC1A994B0B() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_patrol_boat", "initLate", ::_id_85B82DB0A7C98677);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_patrol_boat", "create", ::_id_6A80F5460AC9E725);
  scripts\engine\utility::create_func_ref("patrol_boat", ::_id_57FD1BCC7D1AE375);
}

_id_85B82DB0A7C98677() {
  if(1) {
    return;
  }
  _id_BFE291B401A9BF2A = scripts\engine\utility::getStructArray("patrol_boat_spawn", "targetname");
  thread _id_F41C505F96A5F7F9(_id_BFE291B401A9BF2A, 3);
}

_id_F41C505F96A5F7F9(_id_70DAB3207FB65169, delay) {
  wait(delay);
  _id_915E6307FD669235 = getdvarint("r_reflectionprobegenerate", 0) == 0;

  if(_id_915E6307FD669235) {
    foreach(struct in _id_70DAB3207FB65169) {
      spawndata = spawnStruct();
      spawndata.origin = struct.origin;
      spawndata.angles = struct.angles;
      vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_patrol_boat", spawndata);

      if(isDefined(vehicle))
        level._id_9AB8E1FAE12997D7 = scripts\engine\utility::array_add(level._id_9AB8E1FAE12997D7, vehicle);
    }
  }
}

_id_6A80F5460AC9E725(vehicle) {
  vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth(vehicle);
  vehicle.health = vehicle.maxhealth;
}

_id_57FD1BCC7D1AE375(player) {
  spawndata = spawnStruct();
  spawndata.origin = player.origin + (0, 0, 100);
  spawndata.angles = player.angles * (0, 1, 0);
  spawndata.owner = player;
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_patrol_boat", spawndata);

  if(isDefined(vehicle))
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(vehicle, "driver", player, undefined, 1);
}