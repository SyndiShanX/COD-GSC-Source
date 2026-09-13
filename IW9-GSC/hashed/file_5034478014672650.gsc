/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5034478014672650.gsc
***********************************************/

_id_335DD1C457C3A367() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_mkilo23", "initLate", ::_id_F9555F89314D822B);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_mkilo23", "create", ::_id_80C77207370F69C9);
  scripts\engine\utility::create_func_ref("veh9_mkilo23", ::_id_C1E08166E5F36E65);
}

_id_F9555F89314D822B() {
  if(1) {
    return;
  }
  level._id_7F12E5F545DFE91B = [];
  _id_BFE291B401A9BF2A = scripts\engine\utility::getStructArray("mkilo23_spawn", "targetname");
  thread _id_DA744536B72B0F35(_id_BFE291B401A9BF2A, 3);
}

_id_DA744536B72B0F35(_id_70DAB3207FB65169, delay) {
  wait(delay);
  _id_143EC77A5546A43A = getdvarint("r_reflectionprobegenerate", 0) == 0;

  if(_id_143EC77A5546A43A) {
    foreach(struct in _id_70DAB3207FB65169) {
      spawndata = spawnStruct();
      spawndata.origin = struct.origin;
      spawndata.angles = struct.angles;
      vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_mkilo23", spawndata);

      if(isDefined(vehicle))
        level._id_7F12E5F545DFE91B = scripts\engine\utility::array_add(level._id_7F12E5F545DFE91B, vehicle);
    }
  }
}

_id_80C77207370F69C9(vehicle) {
  vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth(vehicle);
  vehicle.health = vehicle.maxhealth;
}

_id_C1E08166E5F36E65(player) {
  spawndata = spawnStruct();
  spawndata.origin = player.origin + (0, 0, 100);
  spawndata.angles = player.angles * (0, 1, 0);
  spawndata.owner = player;
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_mkilo23", spawndata);

  if(isDefined(vehicle))
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(vehicle, "driver", player, undefined, 1);
}

convert_aitruck_to_playertruck(vehicle) {
  vehicle notify("death");
  vehicle.vehiclename = "veh9_mkilo23";
  vehicle.maxhealth = 999999;
  vehicle.health = vehicle.maxhealth;
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(vehicle, "neutral");
  vehicle.objweapon = makeweapon(scripts\cp_mp\vehicles\vehicle_damage::_id_7AAA7AE503292F43("veh9_mkilo23"));
  vehicle makeunusable();
  vehicle setCanDamage(1);
  vehicle scripts\cp_mp\emp_debuff::set_start_emp_callback(scripts\cp_mp\vehicles\vehicle::vehicle_empstartcallback);
  vehicle scripts\cp_mp\emp_debuff::set_clear_emp_callback(scripts\cp_mp\vehicles\vehicle::vehicle_empclearcallback);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_registerinstance(vehicle);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_registerinstance(vehicle);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(vehicle);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(vehicle, undefined, undefined);
  scripts\cp_mp\vehicles\vehicle_dlog::vehicle_dlog_spawnevent(vehicle, undefined);
  _id_E9AD534890B3B83E = scripts\cp_mp\utility\weapon_utility::setlockedoncallback;
  [[_id_E9AD534890B3B83E]](vehicle, scripts\cp_mp\vehicles\vehicle::vehicle_lockedoncallback);
  _id_0CFDE26882EFC85E = scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback;
  [[_id_0CFDE26882EFC85E]](vehicle, scripts\cp_mp\vehicles\vehicle::vehicle_lockedonremovedcallback);
  vehicle thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("veh9_mkilo23", "create"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("veh9_mkilo23", "create")]](vehicle);

  return vehicle;
}