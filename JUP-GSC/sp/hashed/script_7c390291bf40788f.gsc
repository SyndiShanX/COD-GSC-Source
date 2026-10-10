/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_7c390291bf40788f.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp\vehicles\vehicle_oob_cp;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_mines;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;
#namespace namespace_32bc29716721be3a;

function function_59eb5f2de04c842a() {
  create_func_ref("little_bird", &spawn_and_enter_little_bird);
  registersharedfunc("veh9_palfa", "create", &function_e142f49f5fd8fc5c);
  registersharedfunc("veh9_palfa", "initLate", &function_eb07b052f2b17526);
}

function function_e142f49f5fd8fc5c(vehicle) {
  vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth(vehicle);
  vehicle.health = vehicle.maxhealth;
}

function function_eb07b052f2b17526() {
  if(true) {
    return;
  }

  level.littlebirds = [];
  spawnstructs = getStructArray("littlebird_spawn", "targetname");
  thread function_c5b7425291a048f2(spawnstructs, 3);
}

function function_c5b7425291a048f2(structarray, delay) {
  wait delay;
  var_afee914574e657b8 = getdvarint(@ "hash_e6afce2cf5cf7515", 0) == 0;

  if(var_afee914574e657b8) {
    foreach(struct in structarray) {
      spawndata = spawnStruct();
      spawndata.origin = struct.origin;
      spawndata.angles = struct.angles;
      vehicle = vehicle_spawn("veh9_palfa", spawndata);

      if(isDefined(vehicle)) {
        level.littlebirds = array_add(level.littlebirds, vehicle);
      }
    }
  }

  level notify("little_birds_done_spawning");
}

function spawn_and_enter_little_bird(player) {
  spawndata = spawnStruct();
  spawndata.origin = player.origin + (0, 0, 100);
  spawndata.angles = player.angles * (0, 1, 0);
  spawndata.owner = player;
  vehicle = vehicle_spawn("veh9_palfa", spawndata);

  if(isDefined(vehicle)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(vehicle, "driver", player, undefined, 1);
  }
}

function addtolittlebirdlist(entnumber) {
  if(!isDefined(level.littlebirds)) {
    level.littlebirds = [];
  }

  level.littlebirds[entnumber] = self;
}

function removefromlittlebirdlistondeath(entnumber) {
  self waittill("death");
  level.littlebirds[entnumber] = undefined;
}