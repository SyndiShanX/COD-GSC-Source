/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks_precache.gsc
**************************************/

main() {
  common_scripts\utility::add_destructible_type_function("toy_tv_video_monitor", destructible_scripts\toy_tv_video_monitor::main);
  maps\animated_models\ow_crane_hook::main();
  maps\interactive_models\bldg_01_dest::main();
  maps\interactive_models\egrets::main();
  vehicle_scripts\apache::main("vehicle_apache_iw6", undefined, "script_vehicle_apache_iw6");
  vehicle_scripts\_apache_player::main("apache_cockpit_player", undefined, "script_vehicle_apache_player");
  vehicle_scripts\_gaz_dshk_oilrocks::main("vehicle_gaz_tigr_base_oilrocks", undefined, "script_vehicle_gaz_tigr_turret_oilrocks");
  vehicle_scripts\_gunboat::main("vehicle_gun_boat_iw6", undefined, "script_vehicle_gunboat");
  vehicle_scripts\hind_battle_oilrocks::main("vehicle_battle_hind_no_mg", "hind_battle_oilrocks", "script_vehicle_hind_battle_oilrocks");
  vehicle_scripts\m800::main("vehicle_m800_apc", undefined, "script_vehicle_m800");
  vehicle_scripts\silenthawk::main("vehicle_silenthawk", undefined, "script_vehicle_silenthawk_oilrocks");
  vehicle_scripts\_zpu_antiair_oilrocks::main("vehicle_zpu4_low", undefined, "script_vehicle_zpu4_oilrocks");
}