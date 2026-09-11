/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\zuniform.gsc
***********************************************/

#using_animtree("");

function main(var0, var1, var2) {
  scripts\common\vehicle_build::build_template("zuniform", var0, var1, var2);
  scripts\common\vehicle_build::build_localinit(&init_local);
  scripts\common\vehicle_build::build_deathmodel(var0, "veh8_civ_lnd_zuniform");
  scripts\common\vehicle_build::build_deathfx("vfx/iw8/veh/scriptables/vfx_veh_explosion_civ.vfx", undefined, "car_explode");
  scripts\common\vehicle_build::build_deathquake(1, 1.6, 500);
  scripts\common\vehicle_build::build_deathanimations(%veh8_common_pickup_expl_lf, %veh8_common_pickup_expl_rf, $veh8_common_pickup_expl_lb, %veh8_common_pickup_expl_rb);
  scripts\common\vehicle_build::build_radiusdamage((0, 0, 0), 500, 120, 20);
  scripts\common\vehicle_build::build_drive(%veh8_common_pickup_driving_idle_forward, %veh8_common_pickup_driving_idle_backward, 10);
  scripts\common\vehicle_build::build_treadfx(var2, "sand", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dust.vfx");
  scripts\common\vehicle_build::build_treadfx(var2, "dirt", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dirt.vfx");
  scripts\common\vehicle_build::build_treadfx(var2, "mud", "vfx/iw8/level/highway/vfx_vehicle_treadfx_mud.vfx");
  scripts\common\vehicle_build::build_life(2000);
  scripts\common\vehicle_build::build_team("axis");
  scripts\common\vehicle_build::build_aianims(&setanims, &set_vehicle_anims);
  scripts\common\vehicle_build::build_unload_groups(&unload_groups);
}

function init_local() {
  self.script_badplace = 1;
}

function setanims() {
  var0 = [];
  return var0;
}

function unload_groups() {
  var0 = [];
  GscBinSkip0(0x2e, "default", []);
}

function set_vehicle_anims(var0) {
  var0 = [];
  return var0;
}