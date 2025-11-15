/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\clockwork_precache.gsc
***************************************/

main() {
  vehicle_scripts\_btr80::main("vehicle_btr80_snow", undefined, "script_vehicle_btr80_snow");
  vehicle_scripts\_gaz::main("vehicle_gaz_tigr_base", "gaz_tigr_turret_physics", "script_vehicle_gaz_tigr_turret_physics");
  vehicle_scripts\_snowmobile::main("vehicle_snowmobile", undefined, "script_vehicle_snowmobile");
  vehicle_scripts\_chinese_brave_warrior::main("vehicle_chinese_brave_warrior_anim", undefined, "script_vehicle_warrior");
  vehicle_scripts\_chinese_brave_warrior::main("vehicle_chinese_brave_warrior_anim", "warrior_opentop_physics", "script_vehicle_warrior_physics");
  vehicle_scripts\_chinese_brave_warrior::main("vehicle_chinese_brave_warrior_anim", "warrior_opentop_physics", "script_vehicle_warrior_physics_turret");
}