/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\little_bird_cp.gsc
**************************************************/

little_bird_cp_init() {
  scripts\engine\utility::create_func_ref("little_bird", ::spawn_and_enter_little_bird);
  scripts\cp_mp\utility\script_utility::registersharedfunc("little_bird", "create", ::little_bird_cp_create);
  scripts\cp_mp\utility\script_utility::registersharedfunc("little_bird", "initLate", ::little_bird_cp_initlate);
}

little_bird_cp_create(vehicle) {
  vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth(vehicle);
  vehicle.health = vehicle.maxhealth;
  vehicle.vehicle_specific_onentervehicle = ::little_bird_cp_onentervehicle;
  vehicle.vehicle_specific_onexitvehicle = ::little_bird_cp_onexitvehicle;
  entnumber = vehicle getentitynumber();
  vehicle addtolittlebirdlist(entnumber);
  vehicle thread removefromlittlebirdlistondeath(entnumber);
}

little_bird_cp_initlate() {
  if(1) {
    return;
  }
  level.littlebirds = [];
  _id_BFE291B401A9BF2A = scripts\engine\utility::getStructArray("littlebird_spawn", "targetname");
  thread little_bird_cp_createfromstructs(_id_BFE291B401A9BF2A, 3);
}

little_bird_cp_createfromstructs(_id_70DAB3207FB65169, delay) {
  wait(delay);
  _id_AFEE914574E657B8 = getdvarint("r_reflectionprobegenerate", 0) == 0;

  if(_id_AFEE914574E657B8) {
    foreach(struct in _id_70DAB3207FB65169) {
      spawndata = spawnStruct();
      spawndata.origin = struct.origin;
      spawndata.angles = struct.angles;
      vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("little_bird", spawndata);

      if(isDefined(vehicle))
        level.littlebirds = scripts\engine\utility::array_add(level.littlebirds, vehicle);
    }
  }

  level notify("little_birds_done_spawning");
}

spawn_and_enter_little_bird(player) {
  spawndata = spawnStruct();
  spawndata.origin = player.origin + (0, 0, 100);
  spawndata.angles = player.angles * (0, 1, 0);
  spawndata.owner = player;
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("little_bird", spawndata);

  if(isDefined(vehicle))
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(vehicle, "driver", player, undefined, 1);
}

little_bird_cp_onentervehicle(vehicle, _id_7558F98F3236963D, player, data) {}

little_bird_cp_onexitvehicle(vehicle, _id_FC7C7A874B43A31A, player, data) {}

addtolittlebirdlist(entnumber) {
  if(!isDefined(level.littlebirds))
    level.littlebirds = [];

  level.littlebirds[entnumber] = self;
}

removefromlittlebirdlistondeath(entnumber) {
  self waittill("death");
  level.littlebirds[entnumber] = undefined;
}