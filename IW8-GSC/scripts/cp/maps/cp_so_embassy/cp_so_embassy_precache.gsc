/********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_so_embassy\cp_so_embassy_precache.gsc
********************************************************************/

function main() {
  scripts\vehicle\blima::main("veh8_mil_air_blima", "blima", "script_vehicle_blima");
  scripts\vehicle\lbravo::main("veh8_mil_air_lbravo", "lbravo", "script_vehicle_iw8_lbravo");
  scripts\vehicle\pindia::main("veh8_mil_lnd_pindia_black", undefined, "script_vehicle_iw8_truck_pindia_black");
  scripts\vehicle\pindia::main("veh8_mil_lnd_pindia_tan", undefined, "script_vehicle_iw8_truck_pindia_tan");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_dirty", undefined, "script_vehicle_iw8_truck_techo_whitedirty");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_rusty_green", undefined, "script_vehicle_iw8_truck_techo_greenrusty");
}