/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6e32c3e5e141c690.gsc
***********************************************/

_id_944A2EB36063F641() {
  level._id_3B897E0BF2FD1085 = [];
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_rhib", "initLate", ::_id_579A147ED98230E5);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_rhib", "create", ::_id_8278682E1F6A45BF);
  scripts\engine\utility::create_func_ref("rhib", ::_id_060DF0D6DD51D625);
}

_id_579A147ED98230E5() {
  _id_BFE291B401A9BF2A = scripts\engine\utility::getStructArray("rhib_spawn", "targetname");

  if(!_id_6D4917219F632BA7()) {
    return;
  }
  thread _id_A5F198848C9214AB(_id_BFE291B401A9BF2A, 3);
}

_id_A5F198848C9214AB(_id_70DAB3207FB65169, delay) {
  wait(delay);
  _id_915E6307FD669235 = getdvarint("r_reflectionprobegenerate", 0) == 0;

  if(_id_915E6307FD669235) {
    foreach(struct in _id_70DAB3207FB65169) {
      spawndata = spawnStruct();
      spawndata.origin = struct.origin;
      spawndata.angles = struct.angles;
      vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_rhib", spawndata);

      if(isDefined(vehicle))
        level._id_3B897E0BF2FD1085 = scripts\engine\utility::array_add(level._id_3B897E0BF2FD1085, vehicle);
    }
  }
}

_id_8278682E1F6A45BF(vehicle) {
  vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth(vehicle);
  vehicle.health = vehicle.maxhealth;
}

_id_060DF0D6DD51D625(player) {
  spawndata = spawnStruct();
  spawndata.origin = player.origin + (0, 0, 100);
  spawndata.angles = player.angles * (0, 1, 0);
  spawndata.owner = player;
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_rhib", spawndata);

  if(isDefined(vehicle))
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(vehicle, "driver", player, undefined, 1);
}

_id_6D4917219F632BA7() {
  return istrue(level._id_A81F53987E0482BF);
}