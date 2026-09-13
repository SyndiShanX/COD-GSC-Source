/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7c390291bf40788f.gsc
***********************************************/

_id_59EB5F2DE04C842A() {
  scripts\engine\utility::create_func_ref("little_bird", ::spawn_and_enter_little_bird);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_palfa", "create", ::_id_E142F49F5FD8FC5C);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_palfa", "initLate", ::_id_EB07B052F2B17526);
}

_id_E142F49F5FD8FC5C(vehicle) {
  vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth(vehicle);
  vehicle.health = vehicle.maxhealth;
}

_id_EB07B052F2B17526() {
  if(1) {
    return;
  }
  level.littlebirds = [];
  _id_BFE291B401A9BF2A = scripts\engine\utility::getStructArray("littlebird_spawn", "targetname");
  thread _id_C5B7425291A048F2(_id_BFE291B401A9BF2A, 3);
}

_id_C5B7425291A048F2(_id_70DAB3207FB65169, delay) {
  wait(delay);
  _id_AFEE914574E657B8 = getdvarint("r_reflectionprobegenerate", 0) == 0;

  if(_id_AFEE914574E657B8) {
    foreach(struct in _id_70DAB3207FB65169) {
      spawndata = spawnStruct();
      spawndata.origin = struct.origin;
      spawndata.angles = struct.angles;
      vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_palfa", spawndata);

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
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_palfa", spawndata);

  if(isDefined(vehicle))
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(vehicle, "driver", player, undefined, 1);
}

addtolittlebirdlist(entnumber) {
  if(!isDefined(level.littlebirds))
    level.littlebirds = [];

  level.littlebirds[entnumber] = self;
}

removefromlittlebirdlistondeath(entnumber) {
  self waittill("death");
  level.littlebirds[entnumber] = undefined;
}