/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nml_precache.gsc
*****************************************************/

main() {
  common_scripts\utility::add_destructible_type_function("toy_generator_on", destructible_scripts\toy_generator_on::main);
  common_scripts\utility::add_destructible_type_function("toy_tv_video_monitor", destructible_scripts\toy_tv_video_monitor::main);
  maps\interactive_models\pigeons::main();
  maps\interactive_models\vulture::main();
  vehicle_scripts\hovercraft::main("vehicle_hovercraft_enemy_nofan", undefined, "script_vehicle_hovercraft_enemy");
  vehicle_scripts\iveco_lynx::main("vehicle_iveco_lynx_iw6", undefined, "script_vehicle_iveco_lynx");
  vehicle_scripts\iveco_lynx::main("vehicle_iveco_lynx_iw6", "iveco_lynx_physics", "script_vehicle_iveco_lynx_physics");
  vehicle_scripts\m800::main("vehicle_m800_apc", undefined, "script_vehicle_m800");
  vehicle_scripts\nh90::main("vehicle_nh90", undefined, "script_vehicle_nh90");
  vehicle_scripts\tatra_t815::main("vehicle_tatra_t815_iw6", undefined, "script_vehicle_tatra_t815");
  vehicle_scripts\_foliage_tumbleweed_vehicle::main("foliage_tumbleweed", undefined, "script_vehicle_tumbleweed");
}