/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\light_tank_cp.gsc
*************************************************/

light_tank_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "create", ::light_tank_cp_create);
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "initLate", ::light_tank_cp_initlate);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_limitgameinstances("light_tank", 6);
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "onDeathRespawn", ::light_tank_cp_ondeathrespawncallback);
  scripts\engine\utility::create_func_ref("light_tank", ::spawn_and_enter_light_tank);
  scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328("light_tank").showheadicontoenemy = 1;
}

light_tank_cp_initlate() {
  if(1) {
    return;
  }
  level.largetransports = [];
  _id_BFE291B401A9BF2A = scripts\engine\utility::getStructArray("lighttank_spawn", "targetname");
  thread light_tank_cp_createfromstructs(_id_BFE291B401A9BF2A, 3);
}

light_tank_cp_createfromstructs(_id_70DAB3207FB65169, delay) {
  wait(delay);
  _id_915E6307FD669235 = getdvarint("r_reflectionprobegenerate", 0) == 0;

  if(_id_915E6307FD669235) {
    foreach(struct in _id_70DAB3207FB65169)
    level.lighttanks = scripts\engine\utility::array_add(level.lighttanks, scripts\cp_mp\vehicles\vehicle::vehicle_spawn("light_tank", struct.origin, struct.angles));
  }
}

light_tank_cp_create(vehicle) {
  vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth(vehicle);
  vehicle.health = vehicle.maxhealth;
  vehicle.vehicle_specific_onentervehicle = ::light_tank_cp_onentervehicle;
  vehicle.vehicle_specific_onexitvehicle = ::light_tank_cp_onexitvehicle;
}

spawn_and_enter_light_tank(player) {
  spawndata = spawnStruct();
  spawndata.origin = player.origin + (0, 0, 100);
  spawndata.angles = player.angles;
  spawndata.owner = player;
  spawndata.team = player.team;
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "initSpawnData")]](spawndata);
  spawndata.spawnmethod = "place_at_position_unsafe";
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("light_tank", spawndata);

  if(isDefined(vehicle))
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(vehicle, "driver", player);
}

light_tank_cp_onentervehicle(vehicle, _id_7558F98F3236963D, player, data) {
  level notify("tank_enter", vehicle);
}

light_tank_cp_onexitvehicle(vehicle, _id_FC7C7A874B43A31A, player, data) {
  level notify("tank_exit", vehicle);
}

light_tank_cp_ondeathrespawncallback() {
  thread light_tank_cp_waitandspawn();
}

light_tank_cp_waitandspawn() {
  _id_575EF651FFAB4369 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  spawndata = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(_id_575EF651FFAB4369, spawndata);
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "copySpawnData")]](_id_575EF651FFAB4369, spawndata);
  _id_EE8DA5624236DC89 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("light_tank")) {
      vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("light_tank", spawndata, _id_EE8DA5624236DC89);

      if(!isDefined(vehicle)) {
        continue;
      }
      break;
    }
  }
}