/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\tunnels\tunnels_precache.gsc
************************************************/

main() {
  scripts\engine\sp\utility::offhandprecache(["molotov"]);
  scripts\sp\equipment\tripwire::precache();
  scripts\sp\equipment\tripwire::precachetrap("tripwire_trap_semtex", "offhand_wm_grenade_semtex", 1);
  scripts\vehicle\lbravo::main("veh8_mil_air_lbravo", "lbravo", "script_vehicle_iw8_lbravo_carrier");
}