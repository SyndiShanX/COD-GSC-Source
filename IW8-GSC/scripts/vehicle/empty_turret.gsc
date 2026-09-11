/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\empty_turret.gsc
***********************************************/

function main(var0, var1, var2) {
  scripts\common\vehicle_build::build_template("empty_turret", var0, var1, var2);
  scripts\common\vehicle_build::build_localinit(&init_local);
  scripts\common\vehicle_build::build_deathfx("vfx/iw8/char/blood/vfx_deathfx_bloodpool_01.vfx", undefined, "bullet_explode_flesh_torso_plr");
  scripts\common\vehicle_build::build_life(200, 180, 230);
  scripts\common\vehicle_build::build_team("axis");
}

function init_local() {
  self.vehicleanimalias = "vehicle_turret";
}