/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\deer_hunt_precache.gsc
***************************************/

main() {
  common_scripts\utility::add_destructible_type_function("toy_generator_on", destructible_scripts\toy_generator_on::main);
  common_scripts\utility::add_destructible_type_function("toy_lv_trash_can_vegas", destructible_scripts\toy_lv_trash_can_vegas::main);
  destructible_scripts\toy_lv_trash_can_vegas::main();
  maps\interactive_models\pigeons::main();
  vehicle_scripts\_a10_warthog::main("vehicle_a10_warthog", undefined, "script_vehicle_a10_warthog_cheap");
  vehicle_scripts\aas_72x::main("vehicle_aas_72x", undefined, "script_vehicle_aas72x");
  vehicle_scripts\hind_battle_oilrocks::main("vehicle_battle_hind_no_mg", "hind_battle_oilrocks", "script_vehicle_hind_battle_oilrocks");
  vehicle_scripts\m1a2::main("vehicle_m1a2_abrams_iw6", undefined, "script_vehicle_m1a2_nocoax");
  vehicle_scripts\matv::main("vehicle_matv_no_top", undefined, "script_vehicle_matv_noturret");
  vehicle_scripts\silenthawk::main("vehicle_silenthawk", undefined, "script_vehicle_silenthawk");
}