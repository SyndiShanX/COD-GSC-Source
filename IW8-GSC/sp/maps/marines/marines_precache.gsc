/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\marines\marines_precache.gsc
************************************************/

main() {
  scripts\sp\equipment\tripwire::precache();
  scripts\sp\equipment\tripwire::precachetrap("tripwire_trap_frag", "offhand_wm_grenade_mike67", 1);
  scripts\sp\equipment\tripwire::precachetrap("tripwire_trap_semtex", "offhand_wm_grenade_semtex", 1);
  scripts\vehicle\apache::main("veh8_mil_air_ahotel64_ks", "apache", "script_vehicle_apache");
  scripts\vehicle\asierra::main("veh8_mil_lnd_asierra_tan", undefined, "script_vehicle_iw8_apc_asierra_tan");
  scripts\vehicle\bromeo::main("veh8_mil_lnd_bromeo", "veh_bromeo", "script_vehicle_bromeo");
  scripts\vehicle\stango::main("veh8_mil_lnd_stango", undefined, "script_vehicle_iw8_apc_stango");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_no_windows_black", undefined, "script_vehicle_iw8_truck_techo_black_nowindows");
}