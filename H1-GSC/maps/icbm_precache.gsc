/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\icbm_precache.gsc
********************************/

main() {
  common_scripts\utility::add_destructible_type_function("vehicle_80s_sedan1_red", destructible_scripts\vehicle_80s_sedan1_red::main);
  common_scripts\utility::add_destructible_type_function("vehicle_80s_wagon1_yel", destructible_scripts\vehicle_80s_wagon1_yel::main);
  common_scripts\utility::add_destructible_type_function("vehicle_uaz_hardtop", destructible_scripts\vehicle_uaz_hardtop::main);
  vehicle_scripts\_bm21_troops::main("vehicle_bm21_mobile_cover_no_bench", undefined, "script_vehicle_bm21_mobile_cover_no_bench");
  vehicle_scripts\_mi17::main("vehicle_mi17_woodland_fly_cheap", undefined, "script_vehicle_mi17_woodland_fly_cheap");
  vehicle_scripts\_uaz::main("vehicle_uaz_hardtop_destructible", undefined, "script_vehicle_uaz_hardtop_destructible");
}