/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks_apache_chain_objective.gsc
****************************************************/

objectives(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = & "OILROCKS_OBJ_APACHE_ANTIAIR";

  var_4 = maps\_utility::obj(var_0);
  objective_add(var_4, "current", var_3);
  objective_current(var_4);
  var_5 = getent(var_1, "targetname");
  var_6 = 3;
  var_7 = spawnStruct();
  var_7.activecount = 0;

  for(var_8 = 0; isDefined(var_5); var_8++) {
    var_5 thread anti_air_objectiv_trigger(var_4, var_8, var_7);

    if(var_7.activecount >= var_6)
      var_7 waittill("countdown");

    if(!isDefined(var_5.target)) {
      break;
    }

    var_5 = getent(var_5.target, "targetname");
  }

  while(var_7.activecount)
    var_7 waittill("countdown");

  if(isDefined(var_2))
    common_scripts\utility::flag_set(var_2);

  maps\_utility::objective_complete(var_4);
}

anti_air_objectiv_trigger(var_0, var_1, var_2) {
  var_2.activecount++;
  find_enemy_vehicles(var_2);

  if(var_2.touching.size) {
    while(var_2.touching.size) {
      maps\_utility::waittill_dead(var_2.touching);
      find_enemy_vehicles(var_2);
    }
  }

  var_2.activecount--;
  var_2 notify("countdown");
}

find_enemy_vehicles(var_0) {
  var_1 = vehicle_getarray();
  var_0.touching = [];
  var_0.points = [];

  foreach(var_3 in var_1) {
    if(isalive(var_3) && ispointinvolume(var_3.origin, self) && var_3.script_team != "allies" && !maps\_vehicle::is_godmode()) {
      var_0.touching[var_0.touching.size] = var_3;
      var_0.points[var_0.points.size] = var_3.origin;
    }
  }
}