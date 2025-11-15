/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\jungle_ghosts_precache.gsc
*******************************************/

main() {
  maps\interactive_models\parakeets::main();
  vehicle_scripts\aas_72x::main("vehicle_aas_72x", undefined, "script_vehicle_aas72x");
  vehicle_scripts\_f15::main("vehicle_f15", undefined, "script_vehicle_f15");
  vehicle_scripts\hind::main("vehicle_battle_hind", "hind_battle", "script_vehicle_hind_battle");
  vehicle_scripts\_soc_r::main("vehicle_soc_r", undefined, "script_vehicle_soc_r");
}