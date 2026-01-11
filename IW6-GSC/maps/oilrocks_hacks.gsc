/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks_hacks.gsc
*****************************************************/

main_pre_load() {
  foreach(var_1 in getEntArray("apache_factory_gaz_road", "targetname")) {
    if(var_1.classname == "script_vehicle_m800") {
      var_1.targetname = "apache_factory_m800_road";
    }
  }

  foreach(var_4 in getEntArray("blackhawk_riders", "script_noteworthy")) {
    if(isDefined(var_4.script_friendname) && var_4.script_friendname == "HeroGuy") {
      var_4.script_friendname = "Logan";
    }
  }

  maps\_utility::post_load_precache(::clean_up_first_half_thread);
}

clean_up_first_half_thread() {
  thread clean_up_first_half();
}

clean_up_first_half() {
  while(level.player.origin[0] < 16000) {
    wait 1;
  }

  var_0 = ["script_vehicle_m800", "script_vehicle_hind_battle_oilrocks", "script_vehicle_zpu4_oilrocks"];
  var_1 = [];
  var_2 = 11088;

  foreach(var_4 in var_0) {
    var_5 = getEntArray(var_4, "classname");

    foreach(var_7 in var_5) {
      if(var_7.origin[0] < var_2) {
        var_1[var_1.size] = var_7;
      }
    }
  }

  while(var_1.size) {
    var_1 = maps\_utility::remove_dead_from_array(var_1);

    if(!var_1.size) {
      break;
    }

    var_1 = common_scripts\utility::array_reverse(sortbydistance(var_1, level.player.origin));

    if(!var_1.size) {
      break;
    }

    var_10 = var_1[0];

    if(distance(var_10.origin, level.player.origin) < 12000) {
      wait 0.5;
      continue;
    }

    var_10 kill();
    wait 5;
  }
}