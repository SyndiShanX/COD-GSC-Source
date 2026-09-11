/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_so_aniyah\cp_so_aniyah_precache.gsc
******************************************************************/

function main() {
  scripts\vehicle\lbravo::main("veh8_mil_air_lbravo", "lbravo_minimap", "script_vehicle_iw8_lbravo");
  scripts\vehicle\pindia::main("veh8_mil_lnd_pindia", "truck_minimap", "script_vehicle_iw8_truck_pindia_white");
  scripts\vehicle\pindia::main("veh8_mil_lnd_pindia_red", "truck_minimap", "script_vehicle_iw8_truck_pindia_red");
  scripts\vehicle\umike::main("veh8_mil_lnd_umike_pickup", undefined, "script_vehicle_iw8_truck_umike_pickup");
  scripts\vehicle\vindia::main("veh8_mil_lnd_vindia_a1", "vindia_minimap", "script_vehicle_iw8_vindia_a1");
}