/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_228478d4175cb3b9.gsc
***********************************************/

_id_7FBB4BDC170016B2() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_suv_1996", "initLate", ::_id_4DD4F9B32D34B37E);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_suv_1996", "create", ::_id_0F264518EA185294);
  scripts\engine\utility::create_func_ref("veh9_suv_1996", ::_id_701902185150632A);
}

_id_4DD4F9B32D34B37E() {
  if(1) {
    return;
  }
  level._id_907D3564338C8280 = [];
  _id_BFE291B401A9BF2A = scripts\engine\utility::getStructArray("suv_1996_spawn", "targetname");
  thread _id_5C3E799013E72B1A(_id_BFE291B401A9BF2A, 3);
}

_id_5C3E799013E72B1A(_id_70DAB3207FB65169, delay) {
  wait(delay);
  _id_A3A86E2FDC8840D9 = getdvarint("r_reflectionprobegenerate", 0) == 0;

  if(_id_A3A86E2FDC8840D9) {
    foreach(struct in _id_70DAB3207FB65169) {
      spawndata = spawnStruct();
      spawndata.origin = struct.origin;
      spawndata.angles = struct.angles;
      vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_suv_1996", spawndata);

      if(isDefined(vehicle))
        level._id_907D3564338C8280 = scripts\engine\utility::array_add(level._id_907D3564338C8280, vehicle);
    }
  }
}

_id_0F264518EA185294(vehicle) {
  vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth(vehicle);
  vehicle.health = vehicle.maxhealth;
  vehicle.vehicle_specific_onentervehicle = ::_id_773ED31FFC2459DF;
  vehicle.vehicle_specific_onexitvehicle = ::_id_B89E8C86F98D3697;
}

_id_701902185150632A(player) {
  spawndata = spawnStruct();
  spawndata.origin = player.origin + (0, 0, 100);
  spawndata.angles = player.angles * (0, 1, 0);
  spawndata.owner = player;
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_suv_1996", spawndata);

  if(isDefined(vehicle))
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(vehicle, "driver", player, undefined, 1);
}

_id_773ED31FFC2459DF(vehicle, _id_7558F98F3236963D, player, data) {
  player._id_6D4D929E7C9D3E5C = 1;

  if(istrue(level._id_D39DF167F3A996B0))
    vehicle setscriptablepartstate("lights", "on");
}

_id_B89E8C86F98D3697(vehicle, _id_7558F98F3236963D, player, data) {
  if(!istrue(data.playerdisconnect))
    player._id_6D4D929E7C9D3E5C = undefined;

  if(istrue(level._id_D39DF167F3A996B0))
    vehicle setscriptablepartstate("lights", "off");
}