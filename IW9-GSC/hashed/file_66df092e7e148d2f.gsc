/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_66df092e7e148d2f.gsc
***********************************************/

_id_974DACE3684B9E9B() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_mil_cargo_truck", "initLate", ::_id_8BFE97A985843FA7);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_mil_cargo_truck", "create", ::_id_A3ADED844DDFFED5);
  scripts\engine\utility::create_func_ref("veh9_mil_cargo_truck", ::_id_B6977E53C5D1B9A1);
}

_id_8BFE97A985843FA7() {
  if(1) {
    return;
  }
  level._id_53A2C539DFBBF4B3 = [];
  _id_BFE291B401A9BF2A = scripts\engine\utility::getStructArray("mil_cargo_truck_spawn", "targetname");
  thread _id_2EED5685649875E9(_id_BFE291B401A9BF2A, 3);
}

_id_2EED5685649875E9(_id_70DAB3207FB65169, delay) {
  wait(delay);
  _id_A3A86E2FDC8840D9 = getdvarint("r_reflectionprobegenerate", 0) == 0;

  if(_id_A3A86E2FDC8840D9) {
    foreach(struct in _id_70DAB3207FB65169) {
      spawndata = spawnStruct();
      spawndata.origin = struct.origin;
      spawndata.angles = struct.angles;
      vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_mil_cargo_truck", spawndata);

      if(isDefined(vehicle))
        level._id_53A2C539DFBBF4B3 = scripts\engine\utility::array_add(level._id_53A2C539DFBBF4B3, vehicle);
    }
  }
}

_id_A3ADED844DDFFED5(vehicle) {
  vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth(vehicle);
  vehicle.health = vehicle.maxhealth;
  vehicle.vehicle_specific_onentervehicle = ::_id_944637D5D83C25B8;
  vehicle.vehicle_specific_onexitvehicle = ::_id_C75BB8069708440A;
}

_id_B6977E53C5D1B9A1(player) {
  spawndata = spawnStruct();
  spawndata.origin = player.origin + (0, 0, 100);
  spawndata.angles = player.angles * (0, 1, 0);
  spawndata.owner = player;
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_mil_cargo_truck", spawndata);

  if(isDefined(vehicle))
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(vehicle, "driver", player, undefined, 1);
}

_id_944637D5D83C25B8(vehicle, _id_7558F98F3236963D, player, data) {
  player._id_6D4D929E7C9D3E5C = 1;

  if(istrue(level._id_D39DF167F3A996B0)) {
    vehicle setscriptablepartstate("tag_light_front_left", "on");
    vehicle setscriptablepartstate("tag_light_front_right", "on");
    vehicle setscriptablepartstate("tag_light_back_left", "on");
    vehicle setscriptablepartstate("tag_light_back_right", "on");
  }
}

_id_C75BB8069708440A(vehicle, _id_7558F98F3236963D, player, data) {
  if(!istrue(data.playerdisconnect))
    player._id_6D4D929E7C9D3E5C = undefined;

  if(istrue(level._id_D39DF167F3A996B0)) {
    vehicle setscriptablepartstate("tag_light_front_left", "off");
    vehicle setscriptablepartstate("tag_light_front_right", "off");
    vehicle setscriptablepartstate("tag_light_back_left", "off");
    vehicle setscriptablepartstate("tag_light_back_right", "off");
  }
}