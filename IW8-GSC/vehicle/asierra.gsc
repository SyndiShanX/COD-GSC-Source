/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: vehicle\asierra.gsc
***********************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  scripts\common\vehicle_build::build_template("apc", var_0, var_1, var_2);
  scripts\common\vehicle_build::build_localinit(::init_local);
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/large_vehicle_explosion.vfx", undefined, "car_explode");
  scripts\common\vehicle_build::build_deathquake(1, 1.6, 500);
  scripts\common\vehicle_build::build_radiusdamage((0, 0, 0), 500, 120, 20);
  scripts\common\vehicle_build::build_drive(%veh8_common_pickup_driving_idle_forward, %veh8_common_pickup_driving_idle_backward, 10);
  scripts\common\vehicle_build::build_treadfx(var_2, "sand", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dust.vfx");
  scripts\common\vehicle_build::build_treadfx(var_2, "dirt", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dirt.vfx");
  scripts\common\vehicle_build::build_life(1500, 1499, 1500);
  scripts\common\vehicle_build::build_team("allies");
  scripts\common\vehicle_build::build_aianims(::setanims, ::set_vehicle_anims, "asierra");
  scripts\common\vehicle_build::build_unload_groups(::unload_groups);
  scripts\common\vehicle_build::build_light(var_2, "headlight_truck_left", "tag_light_front_left", "vfx/misc/car_headlight_truck_L", "headlights");
  scripts\common\vehicle_build::build_light(var_2, "headlight_truck_right", "tag_light_front_right", "vfx/misc/car_headlight_truck_R", "headlights");
  scripts\common\vehicle_build::build_light(var_2, "taillight_truck_right", "tag_light_back_right", "vfx/misc/car_taillight_truck_R", "headlights");
  scripts\common\vehicle_build::build_light(var_2, "taillight_truck_left", "tag_light_back_left", "vfx/misc/car_taillight_truck_L", "headlights");
  scripts\common\vehicle_build::build_light(var_2, "brakelight_truck_right", "tag_light_back_right", "vfx/misc/car_brakelight_truck_R", "brakelights");
  scripts\common\vehicle_build::build_light(var_2, "brakelight_truck_left", "tag_light_back_left", "vfx/misc/car_brakelight_truck_L", "brakelights");
}

init_local() {
  self.script_badplace = 1;
  self.vehicleanimalias = "asierra";
  self.vehicledisableturningwhileshooting = 1;
}

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 8; var_1++)
    var_0[var_1] = spawnStruct();

  var_0[0].bhasgunwhileriding = 0;
  var_0[0].sittag = "TAG_DRIVER";
  var_0[1].sittag = "TAG_PASSENGER_1";
  var_0[2].sittag = "TAG_PASSENGER_2";
  var_0[3].sittag = "TAG_PASSENGER_3";
  var_0[4].sittag = "TAG_PASSENGER_4";
  var_0[5].sittag = "TAG_PASSENGER_5";
  var_0[6].sittag = "TAG_PASSENGER_6";
  var_0[7].sittag = "TAG_PASSENGER_7";
  var_0[0].death_no_ragdoll = 1;
  var_0[1].death_no_ragdoll = 1;
  var_0[2].death_no_ragdoll = 1;
  var_0[3].death_no_ragdoll = 1;
  var_0[4].death_no_ragdoll = 1;
  var_0[5].death_no_ragdoll = 1;
  var_0[6].death_no_ragdoll = 1;
  var_0[7].death_no_ragdoll = 1;
  return var_0;
}

set_vehicle_anims(var_0) {
  var_0[0].vehicle_getoutanim = % vh_asierra_driver_exit_patrol;
  var_0[0].vehicle_getoutanim_clear = 0;
  var_0[0].vehicle_getoutanim_combat = % vh_asierra_driver_exit_combat_idle;
  var_0[0].vehicle_getoutanim_combat_clear = 0;
  var_0[0].vehicle_getoutanim_combat_run = % vh_asierra_driver_exit_combat_run;
  var_0[0].vehicle_getoutanim_combat_run_clear = 0;
  var_0[1].vehicle_getoutanim = % vh_asierra_pass_exit_patrol;
  var_0[1].vehicle_getoutanim_clear = 0;
  var_0[1].vehicle_getoutanim_combat = % vh_asierra_pass_exit_combat_idle;
  var_0[1].vehicle_getoutanim_combat_clear = 0;
  var_0[1].vehicle_getoutanim_combat_run = % vh_asierra_pass_exit_combat_run;
  var_0[1].vehicle_getoutanim_combat_run_clear = 0;
  var_0[7].vehicle_getoutanim = % vh_asierra_bed_exit_patrol;
  var_0[7].vehicle_getoutanim_clear = 0;
  var_0[7].vehicle_getoutanim_combat = % vh_asierra_bed_exit_combat_idle;
  var_0[7].vehicle_getoutanim_combat_clear = 0;
  var_0[7].vehicle_getoutanim_combat_run = % vh_asierra_bed_exit_combat_idle;
  var_0[7].vehicle_getoutanim_combat_run_clear = 0;
  return var_0;
}

unload_groups() {
  var_0 = [];
  var_0["front"] = [0, 1];

  for(var_1 = 0; var_1 < 8; var_1++)
    var_0["default"][var_1] = var_1;

  return var_0;
}