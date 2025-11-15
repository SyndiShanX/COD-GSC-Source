/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\_c17.gsc
*****************************************************/

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("c17", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_boeing_c17");
  maps\_vehicle::build_deathfx("fx/explosions/large_vehicle_explosion", undefined, "explo_metal_rand");
  maps\_vehicle::build_rumble("mig_rumble", 0.2, 0.4, 22600, 0.05, 0.05);
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_team("allies");
  maps\_vehicle::build_is_airplane();
}