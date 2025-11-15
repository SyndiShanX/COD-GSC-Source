/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\enemyhq_precache.gsc
*****************************************************/

main() {
  vehicle_scripts\aas_72x::main("vehicle_aas_72x_noweapon", undefined, "script_vehicle_aas72x_noweapon");
  vehicle_scripts\iveco_lynx::main("vehicle_iveco_lynx_iw6", undefined, "script_vehicle_iveco_lynx");
  vehicle_scripts\iveco_lynx::main("vehicle_iveco_lynx_iw6", "iveco_lynx_physics", "script_vehicle_iveco_lynx_physics");
  vehicle_scripts\iveco_lynx_turret::main("vehicle_iveco_lynx_iw6", "iveco_lynx_turret_physics", "script_vehicle_iveco_lynx_turret_physics");
  vehicle_scripts\_man_7t::main("vehicle_man_7t_k9_iw6", undefined, "script_vehicle_man_7t_k9");
  vehicle_scripts\_man_7t::main("vehicle_man_7t_k9_iw6", "man_7t_physics", "script_vehicle_man_7t_k9_physics");
  vehicle_scripts\_mig29::main("vehicle_mig29_low", undefined, "script_vehicle_mig29_low");
  vehicle_scripts\nh90::main("vehicle_nh90_cheap_full_interior", undefined, "script_vehicle_nh90_cheap_interior");
}