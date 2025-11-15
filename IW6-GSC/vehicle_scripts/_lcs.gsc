/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\_lcs.gsc
*****************************************************/

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("lcs", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_lcs", "vehicle_lcs_destroyed_front");
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("allies");
}