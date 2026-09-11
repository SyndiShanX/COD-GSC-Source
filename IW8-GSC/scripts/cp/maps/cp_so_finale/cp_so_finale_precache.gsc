/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_so_finale\cp_so_finale_precache.gsc
******************************************************************/

function main() {
  scripts\cp_mp\tripwire::precache();
  scripts\cp_mp\tripwire::precachetrap("tripwire_trap_frag", "offhand_wm_grenade_mike67", 1);
  scripts\vehicle\lbravo::main("veh8_mil_air_lbravo_weapons_east", "lbravo", "script_vehicle_iw8_lbravo_guns_east2");
  scripts\vehicle\pindia::main("veh8_mil_lnd_pindia_tan", undefined, "script_vehicle_iw8_truck_pindia_tan");
  scripts\vehicle\umike::main("veh8_mil_lnd_umike_pickup", undefined, "script_vehicle_iw8_truck_umike_pickup");
  scripts\vehicle\vindia::main("veh8_mil_lnd_vindia_a1", "vindia", "script_vehicle_iw8_vindia_a1");
}