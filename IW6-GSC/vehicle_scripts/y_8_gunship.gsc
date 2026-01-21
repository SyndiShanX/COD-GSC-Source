/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\y_8_gunship.gsc
*******************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("y_8", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_y_8");
  maps\_vehicle::build_drive(%y8_gunship_props, undefined, 0);
  maps\_vehicle::build_deathfx("fx/explosions/large_vehicle_explosion", undefined, "explo_metal_rand");
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_team("axis");
  maps\_vehicle::build_is_airplane();
  maps\_vehicle::build_bulletshield(1);
  maps\_vehicle::build_grenadeshield(1);
}