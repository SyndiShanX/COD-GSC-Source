/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\factory_precache.gsc
*****************************************************/

main() {
  maps\animated_models\fence_tarp_80x84_med_01::main();
  maps\interactive_models\oilrig_hanging_jumpsuit::main();
  vehicle_scripts\agv::main("fac_agv", undefined, "script_vehicle_agv");
  vehicle_scripts\_b2::main("vehicle_b2_bomber", undefined, "script_vehicle_b2");
  vehicle_scripts\iveco_lynx::main("vehicle_iveco_lynx_iw6", undefined, "script_vehicle_iveco_lynx");
  vehicle_scripts\iveco_lynx::main("vehicle_iveco_lynx_iw6", "iveco_lynx_physics", "script_vehicle_iveco_lynx_physics");
  vehicle_scripts\iveco_lynx_turret::main("vehicle_iveco_lynx_iw6", undefined, "script_vehicle_iveco_lynx_turret");
  vehicle_scripts\iveco_lynx_turret::main("vehicle_iveco_lynx_iw6", "iveco_lynx_turret_physics", "script_vehicle_iveco_lynx_turret_physics");
  vehicle_scripts\mobile_railgun_cab::main("mobile_railgun_cab", undefined, "script_vehicle_mobilerailgun_cab");
  vehicle_scripts\mobile_railgun_trailer::main("mobile_railgun_trailer", undefined, "script_vehicle_mobilerailgun_trailer");
  vehicle_scripts\nh90::main("vehicle_nh90", undefined, "script_vehicle_nh90");
}