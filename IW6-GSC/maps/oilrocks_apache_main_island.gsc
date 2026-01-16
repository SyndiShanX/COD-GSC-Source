/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks_apache_main_island.gsc
************************************************/

catchup_function() {
  var_0 = ["apache_main_island_zpu"];

  foreach(var_2 in var_0)
  maps\_utility::array_delete(getEntArray(var_2, "targetname"));
}

start() {
  level.player setclienttriggeraudiozone("oilrocks_heli_gunner", 0.1);
  maps\oilrocks_code::spawn_apache_player("apache_escort");
  maps\oilrocks_apache_code::spawn_blackhawk_ally("struct_blackhawk_ally_escort");
  maps\oilrocks_apache_code::spawn_apache_allies("struct_apache_ally_escort_0");
  common_scripts\utility::flag_set("FLAG_apache_chase_vo_done");
  common_scripts\utility::flag_set("FLAG_apache_chase_finished");
}

main() {
  thread maps\oilrocks_apache_hints::apache_hints_island();
  maps\_utility::autosave_by_name();
  enemies();
}

apache_escort_encounter_final_wave_on_spawn() {
  self.attackeraccuracy = 10.0;
}

move_apache_to_main_island() {
  var_0 = maps\oilrocks_apache_code::get_blackhawk_ally();
  var_0 thread maps\_vehicle::vehicle_paths(common_scripts\utility::getstruct("path_blackhawk_to_main_island", "targetname"));
}

enemies() {
  var_0 = maps\oilrocks_apache_code::spawn_vehicles_from_targetname_prunespawning("apache_main_island_zpu");
  maps\oilrocks_apache_chain_objective::objectives("obj_main_island", "start_main_island_obj_chain", undefined, & "OILROCKS_CLEAR_THE_MAIN_ISLAND");
  var_1 = maps\oilrocks_code::array_remove_undefined_dead_or_dying(var_0);
  common_scripts\utility::array_thread(var_1, maps\oilrocks_apache_code::ai_clean_up, 0, 1);
}