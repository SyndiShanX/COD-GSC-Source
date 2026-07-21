/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: vehicle\suniform25.gsc
***********************************************/

main(var_0, var_1, var_2) {
  scripts\common\vehicle_build::build_template("jet", var_0, var_1, var_2);
  scripts\common\vehicle_build::build_localinit(::init_local);
  scripts\common\vehicle_build::build_deathmodel("veh8_mil_air_suniform25");
  scripts\common\vehicle_build::build_radiusdamage((0, 0, 0), 500, 120, 20);
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/large_vehicle_explosion.vfx", undefined, "veh_gen_mtl_expl_jet", undefined, undefined, undefined, undefined, undefined, undefined, 0);
  scripts\common\vehicle_build::build_life(999, 500, 1500);
  scripts\common\vehicle_build::build_rumble("mig_rumble", 0.1, 0.2, 11300, 0.05, 0.05);
  scripts\common\vehicle_build::build_team("axis");
}

init_local() {}

set_vehicle_anims(var_0) {
  return var_0;
}

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 1; var_1++)
    var_0[var_1] = spawnStruct();

  return var_0;
}