/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks_apache_antiair.gsc
********************************************/

catchup_function() {
  var_0 = ["apache_chase_gunboat", "apache_chase_gaz_road", "apache_chase_gunboat_hvt", "apache_chase_zpu", "apache_chase_additional_zpu"];

  foreach(var_2 in var_0)
  maps\_utility::array_delete(getEntArray(var_2, "targetname"));
}

start() {
  level.player setclienttriggeraudiozone("oilrocks_heli_gunner", 0.1);
  maps\oilrocks_code::spawn_apache_player("apache_chase");
  maps\oilrocks_apache_code::spawn_blackhawk_ally("struct_blackhawk_ally_chase");
  maps\oilrocks_apache_code::spawn_apache_allies("struct_apache_ally_chase_0");
}

main() {
  maps\_utility::autosave_by_name();
  thread maps\oilrocks_apache_vo::apache_mission_vo_think(maps\oilrocks_apache_vo::apache_mission_vo_antiair);
  thread apache_chase_allies_apache();
  thread apache_chase_ally_blackhawk_think();

  if(maps\_utility::obj_exists("apache_factory"))
    maps\_utility::objective_complete(maps\_utility::obj("apache_factory"));

  apache_chase_enemies();
}

apache_chase_allies_apache() {
  var_0 = maps\oilrocks_apache_code::get_apache_allies();
  common_scripts\utility::array_thread(var_0, ::apache_chase_ally_apache_think);
}

apache_chase_ally_apache_think() {
  var_0 = maps\oilrocks_apache_code::get_apache_ally_id();
  var_1 = common_scripts\utility::getstruct("apache_chase_ally_path_start_0" + var_0, "script_noteworthy");
  maps\_vehicle::vehicle_paths(var_1);
}

apache_chase_enemies() {
  var_0 = ["apache_gunboats_main_area", "apache_chase_gaz_road", "apache_chase_gunboat_hvt"];
  getent("apache_chase_gunboat_hvt", "targetname").script_vehicle_selfremove = 1;

  foreach(var_2 in var_0)
  maps\_utility::array_spawn_function_targetname(var_2, ::apache_chase_enemies_turret_think_delay);

  var_0 = common_scripts\utility::array_combine(var_0, ["apache_chase_zpu", "apache_chase_additional_zpu"]);
  var_4 = 0.05;
  var_5 = [];

  foreach(var_2 in var_0) {
    if(var_2 == "apache_chase_zpu" || var_2 == "apache_chase_additional_zpu")
      var_5 = common_scripts\utility::array_combine(var_5, spawn_vehicles_not_already_spawning(var_2));
    else
      var_5 = common_scripts\utility::array_combine(var_5, maps\_vehicle_code::spawn_vehicles_from_targetname_newstyle(var_2));

    wait(var_4);
  }

  foreach(var_9 in var_5) {
    if(isDefined(var_9.target) && isDefined(getvehiclenode(var_9.target, "targetname")))
      var_9 thread maps\_vehicle::gopath();
  }

  thread maps\oilrocks_apache_chain_objective::objectives("oilrocks_apache_antiair", "start_anti_air_objective", "FLAG_apache_chase_finished");
  common_scripts\utility::flag_wait("FLAG_apache_chase_finished");

  if(!common_scripts\utility::flag("FLAG_apache_chase_finished"))
    common_scripts\utility::flag_set("FLAG_apache_chase_finished");

  var_11 = maps\oilrocks_code::array_remove_undefined_dead_or_dying(var_5);
  common_scripts\utility::array_thread(var_11, maps\oilrocks_apache_code::ai_clean_up, 0, 1);
}

spawn_vehicles_not_already_spawning(var_0) {
  var_1 = [];
  var_2 = getEntArray(var_0, "targetname");
  var_3 = [];

  foreach(var_5 in var_2) {
    if(!isDefined(var_5.code_classname) || var_5.code_classname != "script_vehicle") {
      continue;
    }
    if(isspawner(var_5) && !isDefined(var_5.vehicle_spawned_thisframe))
      var_1[var_1.size] = maps\_vehicle_code::_vehicle_spawn(var_5);
  }

  return var_1;
}

apache_chase_enemies_turret_think_delay() {
  if(isDefined(self.classname) && issubstr(self.classname, "_gunboat")) {
    self endon("death");
    wait 3.0;
  }

  maps\oilrocks_apache_code::vehicle_ai_turret_think();
}

apache_chase_ally_blackhawk_think() {
  wait 5.0;
  var_0 = maps\oilrocks_apache_code::get_blackhawk_ally();
  var_0 thread maps\_vehicle::vehicle_paths(common_scripts\utility::getstruct("path_blackhawk_chase", "script_noteworthy"));
}