/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\black_ice_precache.gsc
***************************************/

main() {
  common_scripts\utility::add_destructible_type_function("explodable_barrel", destructible_scripts\explodable_barrel::main);
  common_scripts\utility::add_destructible_type_function("toy_electricbox2", destructible_scripts\toy_electricbox2::main);
  common_scripts\utility::add_destructible_type_function("toy_light_ceiling_fluorescent", destructible_scripts\toy_light_ceiling_fluorescent::main);
  common_scripts\utility::add_destructible_type_function("toy_tv_flatscreen_wallmount_02", destructible_scripts\toy_tv_flatscreen_wallmount_02::main);
  common_scripts\utility::add_destructible_type_function("toy_tv_video_monitor", destructible_scripts\toy_tv_video_monitor::main);
  common_scripts\utility::add_destructible_type_function("toy_usa_gas_station_trash_bin_02", destructible_scripts\toy_usa_gas_station_trash_bin_02::main);
  maps\interactive_models\oilrig_hanging_jumpsuit::main();
  vehicle_scripts\_hind::main("vehicle_mi24p_hind_blackice", "hind_blackice", "script_vehicle_mi24p_hind_blackice");
}