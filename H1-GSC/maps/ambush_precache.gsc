/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\ambush_precache.gsc
********************************/

main() {
  common_scripts\utility::add_destructible_type_function("vehicle_80s_hatch1_brn", destructible_scripts\vehicle_80s_hatch1_brn::main);
  common_scripts\utility::add_destructible_type_function("vehicle_80s_hatch1_red", destructible_scripts\vehicle_80s_hatch1_red::main);
  common_scripts\utility::add_destructible_type_function("vehicle_80s_hatch1_yel", destructible_scripts\vehicle_80s_hatch1_yel::main);
  common_scripts\utility::add_destructible_type_function("vehicle_80s_sedan1_silv", destructible_scripts\vehicle_80s_sedan1_silv::main);
  common_scripts\utility::add_destructible_type_function("vehicle_80s_sedan1_yel", destructible_scripts\vehicle_80s_sedan1_yel::main);
  common_scripts\utility::add_destructible_type_function("vehicle_80s_wagon1_green", destructible_scripts\vehicle_80s_wagon1_green::main);
  common_scripts\utility::add_destructible_type_function("vehicle_80s_wagon1_red", destructible_scripts\vehicle_80s_wagon1_red::main);
  common_scripts\utility::add_destructible_type_function("vehicle_bus_destructible", destructible_scripts\vehicle_bus_destructible::main);
  vehicle_scripts\_blackhawk::main("vehicle_blackhawk", undefined, "script_vehicle_blackhawk");
  vehicle_scripts\_bm21_troops::main("vehicle_bm21_mobile_cover", undefined, "script_vehicle_bm21_mobile_cover");
  vehicle_scripts\_bmp::main("vehicle_bmp_woodland_low", undefined, "script_vehicle_bmp_woodland_low");
  vehicle_scripts\_uaz::main("vehicle_uaz_open", undefined, "script_vehicle_uaz_open");
}