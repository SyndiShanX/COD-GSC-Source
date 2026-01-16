/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks_apache_finale.gsc
*******************************************/

start() {
  level.player setclienttriggeraudiozone("oilrocks_heli_gunner", 0.1);
  maps\oilrocks_code::spawn_apache_player("apache_finale");
  maps\oilrocks_apache_code::spawn_apache_allies("struct_apache_ally_finale_0");
  maps\oilrocks_apache_code::spawn_blackhawk_ally("blackhawk_ally_finale", undefined, undefined, 1);
}

main() {
  var_0 = maps\oilrocks_apache_code::get_blackhawk_ally();
  var_0 maps\_utility::ent_flag_init("blackhawk_reached_end");
  thread maps\oilrocks_apache_vo::apache_mission_vo_think(maps\oilrocks_apache_vo::apache_mission_vo_finale);
  thread apache_player_adjust();
  thread blackhawk_path_to_end();
  var_1 = maps\oilrocks_apache_code::objective_protect_start();
  enemies_vehicle();
  var_0 maps\_utility::add_wait(maps\_utility::ent_flag_wait, "blackhawk_reached_end");
  maps\_utility::add_wait(common_scripts\utility::flag_wait, "player_near_ending");
  maps\_utility::do_wait_any();
}

blackhawk_path_to_end() {
  var_0 = maps\oilrocks_apache_code::get_blackhawk_ally();
  var_0 maps\_vehicle::vehicle_paths(common_scripts\utility::getstruct("blackhawk_to_end", "targetname"));
}

apache_player_adjust() {
  var_0 = maps\oilrocks_apache_code::get_apache_player();

  if(getdvarfloat("vehHelicopterPitchOffset") != var_0.heli.pitch_offset_ground)
    thread maps\_utility::lerp_saveddvar("vehHelicopterPitchOffset", var_0.heli.pitch_offset_ground, 15.0);

  if(isDefined(var_0.alt_override))
    var_0 thread vehicle_scripts\_apache_player::altitude_min_override_remove(20.0);
}

enemies_vehicle() {
  var_0 = ["apache_finale_gaz", "apache_finale_gaz_loop_CW", "apache_finale_gaz_loop_CCW"];

  foreach(var_2 in var_0) {
    maps\_utility::array_spawn_function_targetname(var_2, maps\oilrocks_apache_code::vehicle_ai_turret_think);
    maps\_utility::array_spawn_function_targetname(var_2, ::enemy_vehicle_wave_on_spawn);
  }

  var_4 = 0.05;
  var_5 = ["apache_finale_gaz", "apache_finale_gaz_loop_CW", "apache_finale_gaz_loop_CCW"];

  foreach(var_2 in var_5) {
    maps\_vehicle::spawn_vehicles_from_targetname_and_drive(var_2);
    wait(var_4);
  }

  enemy_waittill_count("apache_finale_enemy_vehicle", 2);
}

enemy_vehicle_wave_on_spawn() {
  self.targetname = "apache_finale_enemy_vehicle";
}

enemy_waittill_count(var_0, var_1) {
  var_2 = getEntArray(var_0, "targetname");

  for(var_2 = maps\oilrocks_code::array_remove_undefined_dead_or_dying(var_2); var_2.size > var_1; var_2 = maps\oilrocks_code::array_remove_undefined_dead_or_dying(var_2)) {
    wait 0.05;
    var_2 = getEntArray("apache_finale_enemy_vehicle", "targetname");
  }
}