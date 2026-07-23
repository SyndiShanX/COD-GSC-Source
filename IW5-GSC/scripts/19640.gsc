/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\19640.gsc
**************************************/

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("zubr", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("russian_zubr_watercraft");
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("axis");
}

init_local() {}