/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_31e1ae5e1ddce676.gsc
***********************************************/

_id_F8CD879642397A71() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_sedan_hatchback_1985", "initLate", ::_id_155DE152AD763CF5);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_sedan_hatchback_1985", "create", ::_id_54D66E9828E8498F);
  scripts\engine\utility::create_func_ref("veh9_sedan_hatchback_1985", ::_id_701902185150632A);
}

_id_155DE152AD763CF5() {
  if(1) {
    return;
  }
  level._id_907D3564338C8280 = [];
  _id_BFE291B401A9BF2A = scripts\engine\utility::getStructArray("sedan_hatchback_1985_spawn", "targetname");
  thread _id_F0918A0308E39DFB(_id_BFE291B401A9BF2A, 3);
}

_id_F0918A0308E39DFB(_id_70DAB3207FB65169, delay) {
  wait(delay);
  _id_A3A86E2FDC8840D9 = getdvarint("r_reflectionprobegenerate", 0) == 0;

  if(_id_A3A86E2FDC8840D9) {
    foreach(struct in _id_70DAB3207FB65169) {
      spawndata = spawnStruct();
      spawndata.origin = struct.origin;
      spawndata.angles = struct.angles;
      vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_sedan_hatchback_1985", spawndata);

      if(isDefined(vehicle))
        level._id_907D3564338C8280 = scripts\engine\utility::array_add(level._id_907D3564338C8280, vehicle);
    }
  }
}

_id_54D66E9828E8498F(vehicle) {
  vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth(vehicle);
  vehicle.health = vehicle.maxhealth;
  vehicle.vehicle_specific_onentervehicle = ::_id_7DF76584D6078B46;
  vehicle.vehicle_specific_onexitvehicle = ::_id_40CE047405104C04;
}

_id_701902185150632A(player) {
  spawndata = spawnStruct();
  spawndata.origin = player.origin + (0, 0, 100);
  spawndata.angles = player.angles * (0, 1, 0);
  spawndata.owner = player;
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_sedan_hatchback_1985", spawndata);

  if(isDefined(vehicle))
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(vehicle, "driver", player, undefined, 1);
}

_id_7DF76584D6078B46(vehicle, _id_7558F98F3236963D, player, data) {
  player._id_6D4D929E7C9D3E5C = 1;

  if(istrue(level._id_D39DF167F3A996B0)) {
    vehicle setscriptablepartstate("tag_light_front_left", "on");
    vehicle setscriptablepartstate("tag_light_front_right", "on");
    vehicle setscriptablepartstate("tag_light_back_left", "on");
    vehicle setscriptablepartstate("tag_light_back_right", "on");
  }
}

_id_40CE047405104C04(vehicle, _id_7558F98F3236963D, player, data) {
  if(!istrue(data.playerdisconnect))
    player._id_6D4D929E7C9D3E5C = undefined;

  if(istrue(level._id_D39DF167F3A996B0)) {
    vehicle setscriptablepartstate("tag_light_front_left", "off");
    vehicle setscriptablepartstate("tag_light_front_right", "off");
    vehicle setscriptablepartstate("tag_light_back_left", "off");
    vehicle setscriptablepartstate("tag_light_back_right", "off");
  }
}