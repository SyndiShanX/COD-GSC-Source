/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5ef6975905ae15bf.gsc
***********************************************/

_id_52B33E520A612E1C() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_jltv", "initLate", ::_id_31EFF11A148FBC30);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_jltv", "create", ::_id_68DA0D25621653A2);
  scripts\engine\utility::create_func_ref("veh9_jltv", ::_id_B834A10D1A3C90BC);
}

_id_31EFF11A148FBC30() {
  if(1) {
    return;
  }
  level._id_66A1156521EE6DEA = [];
  _id_BFE291B401A9BF2A = scripts\engine\utility::getStructArray("jltv_spawn", "targetname");
  thread _id_33ED3784F4D58D80(_id_BFE291B401A9BF2A, 3);
}

_id_33ED3784F4D58D80(_id_70DAB3207FB65169, delay) {
  wait(delay);
  _id_A3A86E2FDC8840D9 = getdvarint("r_reflectionprobegenerate", 0) == 0;

  if(_id_A3A86E2FDC8840D9) {
    foreach(struct in _id_70DAB3207FB65169) {
      spawndata = spawnStruct();
      spawndata.origin = struct.origin;
      spawndata.angles = struct.angles;
      vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_jltv", spawndata);

      if(isDefined(vehicle))
        level._id_66A1156521EE6DEA = scripts\engine\utility::array_add(level._id_66A1156521EE6DEA, vehicle);
    }
  }
}

_id_68DA0D25621653A2(vehicle) {
  vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth(vehicle);
  vehicle.health = vehicle.maxhealth;
}

_id_B834A10D1A3C90BC(player) {
  spawndata = spawnStruct();
  spawndata.origin = player.origin + (0, 0, 100);
  spawndata.angles = player.angles * (0, 1, 0);
  spawndata.owner = player;
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_jltv", spawndata);

  if(isDefined(vehicle))
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(vehicle, "driver", player, undefined, 1);
}