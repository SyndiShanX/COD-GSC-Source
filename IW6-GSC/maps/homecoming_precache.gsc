/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\homecoming_precache.gsc
****************************************/

main() {
  vehicle_scripts\_a10_warthog::main("vehicle_a10_warthog_iw6", undefined, "script_vehicle_a10_warthog");
  vehicle_scripts\_a10_warthog::main("vehicle_a10_warthog", undefined, "script_vehicle_a10_warthog_cheaper");
  vehicle_scripts\aas_72x::main("vehicle_aas_72x_noweapon", undefined, "script_vehicle_aas72x_noweapon");
  vehicle_scripts\artemis::main("vehicle_artemis_30", undefined, "script_vehicle_artemis");
  vehicle_scripts\hind::main("vehicle_battle_hind", "hind_battle", "script_vehicle_hind_battle");
  vehicle_scripts\hovercraft::main("vehicle_hovercraft_enemy_nofan", undefined, "script_vehicle_hovercraft_enemy");
  vehicle_scripts\hovercraft::main("vehicle_hovercraft_enemy", undefined, "script_vehicle_hovercraft_enemy_bottomfans");
  vehicle_scripts\m1a2::main("vehicle_m1a2_abrams_iw6", undefined, "script_vehicle_m1a2_nocoax");
  vehicle_scripts\_mig29::main("vehicle_mig29_low", undefined, "script_vehicle_mig29_low");
  vehicle_scripts\mk23::main("vehicle_mk23_truck_iw6", undefined, "script_vehicle_mk23");
  vehicle_scripts\nh90::main("vehicle_nh90", undefined, "script_vehicle_nh90");
  vehicle_scripts\nh90::main("vehicle_nh90_cheap", undefined, "script_vehicle_nh90_cheap");
  vehicle_scripts\nh90::main("vehicle_nh90_homecoming_vista", undefined, "script_vehicle_nh90_cheaper");
  vehicle_scripts\_osprey::main("vehicle_v22_osprey_iw6_full", "osprey_heli", "script_vehicle_osprey_heli");
  vehicle_scripts\t90ms::main("vehicle_t90ms_tank_iw6", "t90_trophy", "script_vehicle_t90ms_trophy");
}