/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\safehouse_finale\safehouse_finale_precache.gsc
******************************************************************/

main() {
  scripts\engine\sp\utility::offhandprecache(["flash"]);
  scripts\vehicle\apache::main("veh8_mil_air_ahotel64_ks", "apache", "script_vehicle_apache");
  scripts\vehicle\drone_improvised::main("veh8_ind_air_bombing_drone", "drone_improvised", "script_vehicle_drone_improvised");
  scripts\vehicle\lbravo::main("veh8_mil_air_lbravo_east", "lbravo", "script_vehicle_iw8_lbravo_carrier_east");
  scripts\vehicle\lbravo::main("veh8_mil_air_lbravo_east", "lbravo", "script_vehicle_iw8_lbravo_guns_east");
  scripts\vehicle\mindia8::main("veh8_mil_air_mindia8", "mindia8", "script_vehicle_iw8_mindia8_closed");
  scripts\vehicle\pindia::main("veh8_mil_lnd_pindia_tan", undefined, "script_vehicle_iw8_truck_pindia_tan");
  scripts\vehicle\tromeo::main("veh8_mil_lnd_tromeo_black", undefined, "script_vehicle_iw8_tromeo_urban");
  scripts\vehicle\umike::main("veh8_mil_lnd_umike", undefined, "script_vehicle_iw8_truck_umike_covered");
  scripts\vehicle\umike::main("veh8_mil_lnd_umike_physics", "umike_physics_sp", "script_vehicle_iw8_truck_umike_covered_physics");
  scripts\vehicle\vindia::main("veh8_mil_lnd_vindia_a1", "vindia", "script_vehicle_iw8_vindia_a1");
}