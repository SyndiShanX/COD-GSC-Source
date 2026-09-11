/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\asierra.gsc
***********************************************/

#using_animtree("");

function main(var0, var1, var2) {
  scripts\common\vehicle_build::build_template("apc", var0, var1, var2);
  scripts\common\vehicle_build::build_localinit(&init_local);
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/large_vehicle_explosion.vfx", undefined, "car_explode");
  scripts\common\vehicle_build::build_deathquake(1, 1.6, 500);
  scripts\common\vehicle_build::build_radiusdamage((0, 0, 0), 500, 120, 20);
  scripts\common\vehicle_build::build_drive($veh8_common_pickup_driving_idle_forward, %veh8_common_pickup_driving_idle_backward, 10);
  scripts\common\vehicle_build::build_treadfx(var2, "sand", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dust.vfx");
  scripts\common\vehicle_build::build_treadfx(var2, "dirt", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dirt.vfx");
  scripts\common\vehicle_build::build_life(1500, 1499, 1500);
  scripts\common\vehicle_build::build_team("allies");
  scripts\common\vehicle_build::build_aianims(&setanims, &set_vehicle_anims, "asierra");
  scripts\common\vehicle_build::build_unload_groups(&unload_groups);
  scripts\common\vehicle_build::build_light(var2, "headlight_truck_left", "tag_light_front_left", "vfx/misc/car_headlight_truck_L", "headlights");
  scripts\common\vehicle_build::build_light(var2, "headlight_truck_right", "tag_light_front_right", "vfx/misc/car_headlight_truck_R", "headlights");
  scripts\common\vehicle_build::build_light(var2, "taillight_truck_right", "tag_light_back_right", "vfx/misc/car_taillight_truck_R", "headlights");
  scripts\common\vehicle_build::build_light(var2, "taillight_truck_left", "tag_light_back_left", "vfx/misc/car_taillight_truck_L", "headlights");
  scripts\common\vehicle_build::build_light(var2, "brakelight_truck_right", "tag_light_back_right", "vfx/misc/car_brakelight_truck_R", "brakelights");
  scripts\common\vehicle_build::build_light(var2, "brakelight_truck_left", "tag_light_back_left", "vfx/misc/car_brakelight_truck_L", "brakelights");
}

function init_local() {
  self.script_badplace = 1;
  self.vehicleanimalias = "asierra";
  self.vehicledisableturningwhileshooting = 1;
}

function setanims() {
  var0 = [];

  for(var1 = 0; var1 < 8; var1++) {
    var0 = spawnStruct();
  }

  var0[0].bhasgunwhileriding = 0;
  var0[0].sittag = "TAG_DRIVER";
  var0[1].sittag = "TAG_PASSENGER_1";
  var0[2].sittag = "TAG_PASSENGER_2";
  var0[3].sittag = "TAG_PASSENGER_3";
  var0[4].sittag = "TAG_PASSENGER_4";
  var0[5].sittag = "TAG_PASSENGER_5";
  var0[6].sittag = "TAG_PASSENGER_6";
  var0[7].sittag = "TAG_PASSENGER_7";
  var0[0].death_no_ragdoll = 1;
  var0[1].death_no_ragdoll = 1;
  var0[2].death_no_ragdoll = 1;
  var0[3].death_no_ragdoll = 1;
  var0[4].death_no_ragdoll = 1;
  var0[5].death_no_ragdoll = 1;
  var0[6].death_no_ragdoll = 1;
  var0[7].death_no_ragdoll = 1;
  return var0;
}

function set_vehicle_anims(var0) {
  var0[0].vehicle_getoutanim = % vh_asierra_driver_exit_patrol;
  var0[0].vehicle_getoutanim_clear = 0;
  var0[0].vehicle_getoutanim_combat = % vh_asierra_driver_exit_combat_idle;
  var0[0].vehicle_getoutanim_combat_clear = 0;
  var0[0].vehicle_getoutanim_combat_run = % vh_asierra_driver_exit_combat_run;
  var0[0].vehicle_getoutanim_combat_run_clear = 0;
  var0[1].vehicle_getoutanim = % vh_asierra_pass_exit_patrol;
  var0[1].vehicle_getoutanim_clear = 0;
  var0[1].vehicle_getoutanim_combat = % vh_asierra_pass_exit_combat_idle;
  var0[1].vehicle_getoutanim_combat_clear = 0;
  var0[1].vehicle_getoutanim_combat_run = % vh_asierra_pass_exit_combat_run;
  var0[1].vehicle_getoutanim_combat_run_clear = 0;
  var0[7].vehicle_getoutanim = % vh_asierra_bed_exit_patrol;
  var0[7].vehicle_getoutanim_clear = 0;
  var0[7].vehicle_getoutanim_combat = % vh_asierra_bed_exit_combat_idle;
  var0[7].vehicle_getoutanim_combat_clear = 0;
  var0[7].vehicle_getoutanim_combat_run = % vh_asierra_bed_exit_combat_idle;
  var0[7].vehicle_getoutanim_combat_run_clear = 0;
  return var0;
}

function unload_groups() {
  var0 = [];
  GscBinSkip0(0x2e, "front", [0, 1]);
}