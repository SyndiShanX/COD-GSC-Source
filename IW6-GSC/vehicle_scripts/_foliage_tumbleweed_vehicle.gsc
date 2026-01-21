/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\_foliage_tumbleweed_vehicle.gsc
***********************************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("foliage_tumbleweed_vehicle", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_drive(%foliage_tumbleweed_roll_loop1, undefined, 25);
  maps\_vehicle::build_life(1);
}