/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\satfarm_precache.gsc
*****************************************************/

main() {
  vehicle_scripts\_a10_warthog::main("vehicle_a10_warthog", undefined, "script_vehicle_a10_warthog_cheaper");
  vehicle_scripts\_c17::main("vehicle_boeing_c17", "c17", "script_vehicle_c17");
  vehicle_scripts\_gaz::main("vehicle_gaz_tigr_base", "gaz_tigr_turret_physics_sand", "script_vehicle_gaz_tigr_turret_physics_sand");
  vehicle_scripts\hind::main("vehicle_battle_hind_alpha_rotors", "hind_battle", "script_vehicle_hind_battle_sand");
  vehicle_scripts\m1a2_player::main("vehicle_m1a2_abrams_bird", "m1a1_sand", "script_vehicle_m1a2_abrams_bird");
  vehicle_scripts\m1a2_player::main("vehicle_m1a2_abrams_breaper", "m1a1_sand", "script_vehicle_m1a2_abrams_breaper");
  vehicle_scripts\m1a2_player::main("vehicle_m1a2_abrams_viewmodel", "m1a1_player_drivable_relative_physics", "script_vehicle_m1a2_abrams_player_drivable_relative_physics");
  vehicle_scripts\m1a2_player::main("vehicle_m1a2_abrams_iw6", "m1a1_sand", "script_vehicle_m1a2_abrams_sand");
  vehicle_scripts\_m880_launcher::main("vehicle_m880_launcher", "m880_launcher_physics", "script_vehicle_m880_launcher_physics");
  vehicle_scripts\_mig29::main("vehicle_mig29_low", undefined, "script_vehicle_mig29_low_cheap");
  vehicle_scripts\silenthawk::main("vehicle_silenthawk", undefined, "script_vehicle_silenthawk_open");
  vehicle_scripts\silenthawk::main("vehicle_silenthawk", undefined, "script_vehicle_silenthawk_player_turret_left");
  vehicle_scripts\t90ms::main("vehicle_t90ms_tank_iw6", "t90_sand", "script_vehicle_t90ms_sand");
}