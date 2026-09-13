/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_46cb4299182c74f9.gsc
***********************************************/

_id_A66A9D83B9E60DB0() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_techo_rebel_armor", "initLate", ::_id_65C11E7437C3FB6C);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_techo_rebel_armor", "create", ::_id_7E4187D5451AC0CE);
  scripts\engine\utility::create_func_ref("techo_rebel", ::_id_B1C91C65E339DB66);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_techo_rebel_armor", "armorDamageMitigation", ::_id_507809C631729C41);
}

_id_507809C631729C41(partname, meansofdeath, damagelocation, objweapon) {
  if(isDefined(objweapon.basename) && objweapon.basename == "chopper_gunner_turret_cp")
    return 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("veh9_techo_rebel_armor", "armorShouldMitigateDamage"))
    return self[[scripts\cp_mp\utility\script_utility::getsharedfunc("veh9_techo_rebel_armor", "armorShouldMitigateDamage")]](partname, meansofdeath, damagelocation, objweapon);
}

_id_65C11E7437C3FB6C() {
  if(1) {
    return;
  }
  _id_BFE291B401A9BF2A = scripts\engine\utility::getStructArray("techo_rebel_spawn", "targetname");
  thread _id_22C6C4E475BB08D4(_id_BFE291B401A9BF2A, 3);
}

_id_22C6C4E475BB08D4(_id_70DAB3207FB65169, delay) {
  wait(delay);
  _id_915E6307FD669235 = getdvarint("r_reflectionprobegenerate", 0) == 0;

  if(_id_915E6307FD669235) {
    foreach(struct in _id_70DAB3207FB65169) {
      spawndata = spawnStruct();
      spawndata.origin = struct.origin;
      spawndata.angles = struct.angles;
      vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_techo_rebel_armor", spawndata);

      if(isDefined(vehicle))
        level.tacrovers = scripts\engine\utility::array_add(level.tacrovers, vehicle);
    }
  }
}

_id_7E4187D5451AC0CE(vehicle) {
  vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth(vehicle);
  vehicle.health = vehicle.maxhealth;
  vehicle.vehicle_specific_onentervehicle = ::_id_8603FB4F33894A3D;
  vehicle.vehicle_specific_onexitvehicle = ::_id_42CFF90EC61377E1;
}

_id_B1C91C65E339DB66(player) {
  spawndata = spawnStruct();
  spawndata.origin = player.origin + (0, 0, 100);
  spawndata.angles = player.angles * (0, 1, 0);
  spawndata.owner = player;
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_techo_rebel_armor", spawndata);

  if(isDefined(vehicle))
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(vehicle, "driver", player, undefined, 1);
}

#using_animtree("mp_vehicles_always_loaded");

_id_8603FB4F33894A3D(vehicle, _id_7558F98F3236963D, player, data) {
  vehicle notify("player_entered_enemy_vehicle");

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

_id_42CFF90EC61377E1(vehicle, _id_7558F98F3236963D, player, data) {
  if(!istrue(data.playerdisconnect))
    player._id_6D4D929E7C9D3E5C = undefined;

  vehicle._id_1AB6B61153087915 = undefined;
}