/************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_so_safehouse\cp_so_safehouse_precache.gsc
************************************************************************/

function main() {
  scripts\vehicle\lbravo::main("veh8_mil_air_lbravo", "lbravo", "script_vehicle_iw8_lbravo_carrier");
  scripts\vehicle\lbravo::main("veh8_mil_air_lbravo_east", "lbravo", "script_vehicle_iw8_lbravo_carrier_east");
  scripts\vehicle\lbravo::main("veh8_mil_air_lbravo_east", "lbravo", "script_vehicle_iw8_lbravo_guns_east");
  scripts\vehicle\lbravo::main("veh8_mil_air_lbravo_weapons_east", "lbravo", "script_vehicle_iw8_lbravo_guns_east2");
  scripts\vehicle\tromeo::main("veh8_mil_lnd_tromeo_physics", "tromeo_physics", "script_vehicle_iw8_tromeo_desert_physics");
}