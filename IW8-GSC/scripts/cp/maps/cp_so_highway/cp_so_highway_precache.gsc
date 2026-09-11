/********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_so_highway\cp_so_highway_precache.gsc
********************************************************************/

function main() {
  scripts\vehicle\blima::main("veh8_mil_air_blima", "blima", "script_vehicle_blima");
  scripts\vehicle\lbravo::main("veh8_mil_air_lbravo", "lbravo", "script_vehicle_iw8_lbravo");
  scripts\vehicle\mindia8::main("veh8_mil_air_mindia8_open_back_playerride", "mindia8", "script_vehicle_iw8_mindia8_playerride");
  scripts\vehicle\pindia::main("veh8_mil_lnd_pindia", undefined, "script_vehicle_iw8_truck_pindia_white");
  scripts\vehicle\pindia::main("veh8_mil_lnd_pindia_cream", undefined, "script_vehicle_iw8_truck_pindia_cream");
  scripts\vehicle\pindia::main("veh8_mil_lnd_pindia_red", undefined, "script_vehicle_iw8_truck_pindia_red");
  scripts\vehicle\pindia::main("veh8_mil_lnd_pindia_tan", undefined, "script_vehicle_iw8_truck_pindia_tan");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_rebel", undefined, "script_vehicle_iw8_truck_techo_rebel");
}