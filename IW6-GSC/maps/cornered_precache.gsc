/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\cornered_precache.gsc
**************************************/

main() {
  maps\animated_models\accessories_windsock_wind_medium::main();
  maps\animated_models\com_roofvent3::main();
  vehicle_scripts\hind::main("vehicle_battle_hind_no_lod", "hind_battle", "script_vehicle_battle_hind_no_lod");
  vehicle_scripts\nh90::main("vehicle_nh90_no_lod", undefined, "script_vehicle_nh90_no_lod");
}