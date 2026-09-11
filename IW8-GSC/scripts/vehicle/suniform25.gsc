/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\suniform25.gsc
***********************************************/

function main(var0, var1, var2) {
  scripts\common\vehicle_build::build_template("jet", var0, var1, var2);
  scripts\common\vehicle_build::build_localinit(&init_local);
  scripts\common\vehicle_build::build_deathmodel("veh8_mil_air_suniform25");
  scripts\common\vehicle_build::build_radiusdamage((0, 0, 0), 500, 120, 20);
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/large_vehicle_explosion.vfx", undefined, "veh_gen_mtl_expl_jet", undefined, undefined, undefined, undefined, undefined, undefined, 0);
  scripts\common\vehicle_build::build_life(999, 500, 1500);
  scripts\common\vehicle_build::build_rumble("mig_rumble", 0.1, 0.2, 11300, 0.05, 0.05);
  scripts\common\vehicle_build::build_team("axis");
}

function init_local() {}

function set_vehicle_anims(var0) {
  return var0;
}

function setanims() {
  var0 = [];

  for(var1 = 0; var1 < 1; var1++) {
    var0 = spawnStruct();
  }

  return var0;
}