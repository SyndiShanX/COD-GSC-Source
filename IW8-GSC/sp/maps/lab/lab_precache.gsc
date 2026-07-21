/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\lab\lab_precache.gsc
***********************************************/

main() {
  scripts\engine\sp\utility::offhandprecache(["frag"]);
  scripts\smartobjects\stealth_exposed_fire_up::main();
  scripts\vehicle\blima::main("veh8_mil_air_blima", "blima", "script_vehicle_blima");
  scripts\vehicle\bromeo::main("veh8_mil_lnd_bromeo", "veh_bromeo", "script_vehicle_bromeo");
  scripts\vehicle\decho::main("veh8_civ_lnd_decho", undefined, "script_vehicle_iw8_decho_white");
  scripts\vehicle\decho::main("veh8_civ_lnd_decho_green", undefined, "script_vehicle_iw8_decho_green");
  scripts\vehicle\decho::main("veh8_civ_lnd_decho_silver", undefined, "script_vehicle_iw8_decho_silver");
  scripts\vehicle\lbravo::main("veh8_mil_air_lbravo_east", "lbravo", "script_vehicle_iw8_lbravo_carrier_east");
  scripts\vehicle\lbravo::main("veh8_mil_air_lbravo_east_no_dyn_bones", "lbravo", "script_vehicle_iw8_lbravo_east_no_dyn_bones");
  scripts\vehicle\mindia8::main("veh8_mil_air_mindia8", "mindia8", "script_vehicle_iw8_mindia8_closed_east");
  scripts\vehicle\mindia8::main("veh8_mil_air_mindia8_barkov", "mindia8", "script_vehicle_iw8_mindia8_open_vm_east");
}