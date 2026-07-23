/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\18790.gsc
**************************************/

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("submarine_nuclear", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_submarine_nuclear");
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("allies");
}

init_local() {}