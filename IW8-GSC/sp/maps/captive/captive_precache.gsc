/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\captive\captive_precache.gsc
************************************************/

main() {
  scripts\smartobjects\stealth_look_down::main();
  scripts\smartobjects\stealth_look_under_10::main();
  scripts\vehicle\decho::main("veh8_civ_lnd_decho_dirty_milgreen", undefined, "script_vehicle_iw8_decho_milgreendirty");
  scripts\vehicle\mindia8::main("veh8_mil_air_mindia8", "mindia8", "script_vehicle_iw8_mindia8_closed_east");
  scripts\vehicle\umike::main("veh8_mil_lnd_umike", undefined, "script_vehicle_iw8_truck_umike_covered");
  scripts\vehicle\umike::main("veh8_mil_lnd_umike_pickup", undefined, "script_vehicle_iw8_truck_umike_pickup");
}