/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\las_vegas_precache.gsc
***************************************/

main() {
  common_scripts\utility::add_destructible_type_function("toy_computer_monitor_old", destructible_scripts\toy_computer_monitor_old::main);
  common_scripts\utility::add_destructible_type_function("toy_furniture_coffee_table_modern_02", destructible_scripts\toy_furniture_coffee_table_modern_02::main);
  common_scripts\utility::add_destructible_type_function("toy_lv_light_fixture_01", destructible_scripts\toy_lv_light_fixture_01::main);
  common_scripts\utility::add_destructible_type_function("toy_lv_slot_machine", destructible_scripts\toy_lv_slot_machine::main);
  common_scripts\utility::add_destructible_type_function("toy_lv_trash_can_vegas", destructible_scripts\toy_lv_trash_can_vegas::main);
  common_scripts\utility::add_destructible_type_function("toy_statue_sphinx_small", destructible_scripts\toy_statue_sphinx_small::main);
  common_scripts\utility::add_destructible_type_function("toy_tv_flatscreen_large", destructible_scripts\toy_tv_flatscreen_large::main);
  common_scripts\utility::add_destructible_type_function("toy_tv_flatscreen_large_scale1pt5", destructible_scripts\toy_tv_flatscreen_large_scale1pt5::main);
  common_scripts\utility::add_destructible_type_function("toy_tv_video_monitor", destructible_scripts\toy_tv_video_monitor::main);
  destructible_scripts\toy_lv_light_fixture_01::main();
  destructible_scripts\toy_lv_trash_can_vegas::main();
  destructible_scripts\toy_statue_sphinx_small::main();
  maps\interactive_models\pigeons::main();
  vehicle_scripts\aas_72x_destroy::main("vehicle_aas_72x", undefined, "script_vehicle_aas72x_destroy");
  vehicle_scripts\aas_72x::main("vehicle_aas_72x_noweapon", undefined, "script_vehicle_aas72x_noweapon");
  vehicle_scripts\_f18::main("vehicle_f18_super_hornet", undefined, "script_vehicle_f18_lite");
  vehicle_scripts\silenthawk::main("vehicle_silenthawk", undefined, "script_vehicle_silenthawk_open_lite");
  vehicle_scripts\_foliage_tumbleweed_vehicle::main("foliage_tumbleweed", undefined, "script_vehicle_tumbleweed");
}