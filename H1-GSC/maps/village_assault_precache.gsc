/*********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\village_assault_precache.gsc
*********************************************/

main() {
  common_scripts\utility::add_destructible_type_function("vehicle_80s_sedan1_red", destructible_scripts\vehicle_80s_sedan1_red::main);
  common_scripts\utility::add_destructible_type_function("vehicle_80s_sedan1_tan", destructible_scripts\vehicle_80s_sedan1_tan::main);
  common_scripts\utility::add_destructible_type_function("vehicle_pickup", destructible_scripts\vehicle_pickup::main);
  vehicle_scripts\_bmp::main("vehicle_bmp_woodland", undefined, "script_vehicle_bmp_woodland");
  vehicle_scripts\_mi28::main("vehicle_mi-28_flying", undefined, "script_vehicle_mi28_flying");
}