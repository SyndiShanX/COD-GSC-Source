/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\atv_cp.gsc
***********************************************/

atv_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("atv", "initLate", ::atv_cp_initlate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("atv", "create", ::atv_cp_create);
}

atv_cp_initlate() {
  if(1) {
    return;
  }
  level.atvs = [];
  _id_BFE291B401A9BF2A = scripts\engine\utility::getStructArray("atv_spawn", "targetname");
  thread atv_cp_createfromstructs(_id_BFE291B401A9BF2A, 3);
}

atv_cp_createfromstructs(_id_70DAB3207FB65169, delay) {
  wait(delay);
  _id_915E6307FD669235 = getdvarint("r_reflectionprobegenerate", 0) == 0;

  if(_id_915E6307FD669235) {
    foreach(struct in _id_70DAB3207FB65169) {
      spawndata = spawnStruct();
      spawndata.origin = struct.origin;
      spawndata.angles = struct.angles;
      vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("atv", spawndata);

      if(isDefined(vehicle))
        level.atvs = scripts\engine\utility::array_add(level.atvs, vehicle);
    }
  }
}

atv_cp_create(vehicle) {
  vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth(vehicle);
  vehicle.health = vehicle.maxhealth;
}