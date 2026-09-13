/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_18ae04893bb2f9ac.gsc
***********************************************/

_id_D06448E049FAB02F() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_jltv_mg", "initLate", ::_id_8F390FC5CACCBDC3);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_jltv_mg", "create", ::_id_4620CD961F2D1BA1);
  scripts\engine\utility::create_func_ref("veh9_jltv_mg", ::_id_440ADD0394F4A4A1);
}

_id_8F390FC5CACCBDC3() {
  if(1) {
    return;
  }
  level._id_8101FC8C5DCF3CE3 = [];
  _id_BFE291B401A9BF2A = scripts\engine\utility::getStructArray("jltv_mg_spawn", "targetname");
  thread _id_6347AF8D38C1385D(_id_BFE291B401A9BF2A, 3);
}

_id_6347AF8D38C1385D(_id_70DAB3207FB65169, delay) {
  wait(delay);
  _id_A3A86E2FDC8840D9 = getdvarint("r_reflectionprobegenerate", 0) == 0;

  if(_id_A3A86E2FDC8840D9) {
    foreach(struct in _id_70DAB3207FB65169) {
      spawndata = spawnStruct();
      spawndata.origin = struct.origin;
      spawndata.angles = struct.angles;
      vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_jltv_mg", spawndata);

      if(isDefined(vehicle))
        level._id_8101FC8C5DCF3CE3 = scripts\engine\utility::array_add(level._id_66A1156521EE6DEA, vehicle);
    }
  }
}

_id_4620CD961F2D1BA1(vehicle) {
  vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth(vehicle);
  vehicle.health = vehicle.maxhealth;
  vehicle.vehicle_specific_onentervehicle = ::_id_C8EA1B99067C2FBC;
  vehicle.vehicle_specific_onexitvehicle = ::_id_46C7342379AA9BB6;
}

_id_440ADD0394F4A4A1(player) {
  spawndata = spawnStruct();
  spawndata.origin = player.origin + (0, 0, 100);
  spawndata.angles = player.angles * (0, 1, 0);
  spawndata.owner = player;
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_jltv_mg", spawndata);

  if(isDefined(vehicle))
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(vehicle, "driver", player, undefined, 1);
}

#using_animtree("mp_vehicles_always_loaded");

_id_C8EA1B99067C2FBC(vehicle, _id_7558F98F3236963D, player, data) {
  if(istrue(vehicle.door_open)) {
    vehicle vehicleplayanim(%reb_com_veh8_techo_fl_door_close);
    vehicle.door_open = undefined;
  }

  player._id_6D4D929E7C9D3E5C = 1;

  if(istrue(level._id_D39DF167F3A996B0))
    vehicle setscriptablepartstate("lights", "on");

  if(isDefined(vehicle._id_F24CC3BEEF01650C))
    vehicle._id_1AB6B61153087915 = vehicle._id_F24CC3BEEF01650C;
}

_id_46C7342379AA9BB6(vehicle, _id_7558F98F3236963D, player, data) {
  if(!istrue(data.playerdisconnect))
    player._id_6D4D929E7C9D3E5C = undefined;

  vehicle._id_1AB6B61153087915 = undefined;
}