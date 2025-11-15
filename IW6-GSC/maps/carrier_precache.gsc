/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\carrier_precache.gsc
*****************************************************/

main() {
  vehicle_scripts\aas_72x::main("vehicle_aas_72x", undefined, "script_vehicle_aas72x");
  vehicle_scripts\_f18::main("vehicle_f18_super_hornet", undefined, "script_vehicle_f18");
  vehicle_scripts\_gunboat::main("vehicle_gun_boat_iw6", undefined, "script_vehicle_gunboat");
  vehicle_scripts\hind_battle_carrier::main("vehicle_battle_hind", "hind_battle_oilrocks", "script_vehicle_hind_battle_carrier");
  vehicle_scripts\_mig29::main("vehicle_mig29", undefined, "script_vehicle_mig29");
  vehicle_scripts\_osprey::main("vehicle_v22_osprey_iw6_full", "osprey_heli", "script_vehicle_osprey_heli");
  vehicle_scripts\silenthawk::main("vehicle_silenthawk", undefined, "script_vehicle_silenthawk");
  vehicle_scripts\silenthawk::main("vehicle_silenthawk", undefined, "script_vehicle_silenthawk_open");
  vehicle_scripts\y_8_gunship::main("vehicle_y_8_gunship", undefined, "script_vehicle_y_8_gunship");
  vehicle_scripts\_zodiac::main("vehicle_zodiac_boat_fed_iw6", "zodiac_iw6", "script_vehicle_zodiac_iw6");
}