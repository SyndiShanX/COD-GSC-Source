/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\flood_precache.gsc
*****************************************************/

main() {
  common_scripts\utility::add_destructible_type_function("destructible_civilian_sedan_water_iw6", destructible_scripts\destructible_civilian_sedan_water_iw6::main);
  common_scripts\utility::add_destructible_type_function("destructible_van_water_iw6", destructible_scripts\destructible_van_water_iw6::main);
  common_scripts\utility::add_destructible_type_function("destructible_vehicle_city_car_water", destructible_scripts\destructible_vehicle_city_car_water::main);
  maps\animated_models\flood_palm_tree_tall::main();
  maps\animated_models\flood_palm_tree_tall_no_shadow::main();
  maps\animated_models\tarp_tattered_thin_02::main();
  maps\animated_models\tattered_cloth_medium_01::main();
  maps\animated_models\tattered_cloth_small_02::main();
  vehicle_scripts\_f15::main("vehicle_f15_low", undefined, "script_vehicle_f15_low");
  vehicle_scripts\iveco_lynx::main("vehicle_iveco_lynx_iw6", undefined, "script_vehicle_iveco_lynx");
  vehicle_scripts\m1a2::main("vehicle_m1a2_abrams_iw6", undefined, "script_vehicle_m1a2");
  vehicle_scripts\_m880_launcher::main("vehicle_m880_launcher_flood", undefined, "script_vehicle_m880_launcher_flood");
  vehicle_scripts\_man_7t::main("vehicle_man_7t_iw6", undefined, "script_vehicle_man_7t");
  vehicle_scripts\nh90::main("vehicle_nh90", undefined, "script_vehicle_nh90");
  vehicle_scripts\silenthawk::main("vehicle_silenthawk", undefined, "script_vehicle_silenthawk");
  vehicle_scripts\silenthawk::main("vehicle_silenthawk", undefined, "script_vehicle_silenthawk_flood_player");
  vehicle_scripts\t90ms::main("vehicle_t90ms_tank_iw6", undefined, "script_vehicle_t90ms");
  vehicle_scripts\t90ms::main("vehicle_t90ms_tank_iw6", undefined, "script_vehicle_t90ms_turret");
  vehicle_scripts\t90ms::main("vehicle_t90ms_tank_iw6", "t90ms_weaponcollision", "script_vehicle_t90ms_turret_flood");
}