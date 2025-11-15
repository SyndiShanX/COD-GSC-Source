/********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\village_defend_precache.gsc
********************************************/

main() {
  common_scripts\utility::add_destructible_type_function("vehicle_80s_sedan1_brn", destructible_scripts\vehicle_80s_sedan1_brn::main);
  common_scripts\utility::add_destructible_type_function("vehicle_80s_sedan1_silv", destructible_scripts\vehicle_80s_sedan1_silv::main);
  vehicle_scripts\_seaknight::main("vehicle_ch46e", undefined, "script_vehicle_ch46e");
  vehicle_scripts\_mi17::main("vehicle_mi17_woodland_fly_cheap", undefined, "script_vehicle_mi17_woodland_fly_cheap");
  vehicle_scripts\_t72::main("vehicle_t72_tank_woodland", undefined, "script_vehicle_t72_tank_woodland");
}