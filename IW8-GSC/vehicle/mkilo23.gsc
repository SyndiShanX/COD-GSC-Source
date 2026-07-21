/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: vehicle\mkilo23.gsc
***********************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  scripts\common\vehicle_build::build_template("truck", var_0, var_1, var_2);
  scripts\common\vehicle_build::build_localinit(::init_local);

  if(!isendstr(var_2, "_physics"))
    scripts\common\vehicle_build::build_deathmodel(var_0, "veh8_mil_lnd_mkilo23_static_dst_drone");

  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/large_vehicle_explosion.vfx", undefined, "veh_gen_armored_expl_destr");
  scripts\common\vehicle_build::build_deathquake(1, 1.6, 500);
  scripts\common\vehicle_build::build_radiusdamage((0, 0, 0), 500, 120, 20);
  scripts\common\vehicle_build::build_drive(%veh8_common_pickup_driving_idle_forward, %veh8_common_pickup_driving_idle_backward, 10);
  scripts\common\vehicle_build::build_treadfx(var_2, "sand", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dust.vfx");
  scripts\common\vehicle_build::build_treadfx(var_2, "dirt", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dirt.vfx");
  scripts\common\vehicle_build::build_life(1500, 1499, 1500);
  scripts\common\vehicle_build::build_team("axis");
  scripts\common\vehicle_build::build_aianims(::setanims, ::set_vehicle_anims, "mkilo");
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
  self.vehicleanimalias = "mkilo";
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 2; var_1++)
    var_0[var_1] = spawnStruct();

  var_0[0].bhasgunwhileriding = 0;
  var_0[0].sittag = "TAG_DRIVER";
  var_0[1].sittag = "TAG_PASSENGER";
  var_0[0].getin = % reb_vh_mkilo_driver_get_in;
  var_0[1].getin = % reb_vh_mkilo_pass_get_in;
  var_0[0].idle = % reb_vh_mkilo_driver_idle_search01;
  var_0[1].idle = % reb_vh_mkilo_pass_idle_search01;
  var_0[0].getout = % reb_vh_mkilo_driver_exit_combat_idle;
  var_0[1].getout = % reb_vh_mkilo_pass_exit_combat_idle;
  var_0[0].death = % reb_vh_mkilo_driver_death01;
  var_0[1].death = % reb_vh_mkilo_pass_death01;
  var_0[0].death_no_ragdoll = 1;
  var_0[1].death_no_ragdoll = 1;
  return var_0;
}

unload_groups() {
  var_0 = [];

  for(var_1 = 0; var_1 < 2; var_1++)
    var_0["default"][var_1] = var_1;

  return var_0;
}

#using_animtree("vehicles");

set_vehicle_anims(var_0) {
  var_0[0].vehicle_getoutanim = % vh_mkilo_driver_exit_patrol;
  var_0[0].vehicle_getoutanim_clear = 0;
  var_0[0].vehicle_getoutanim_combat = % vh_mkilo_driver_exit_combat_idle;
  var_0[0].vehicle_getoutanim_combat_clear = 0;
  var_0[0].vehicle_getoutanim_combat_run = % vh_mkilo_driver_exit_combat_run;
  var_0[0].vehicle_getoutanim_combat_run_clear = 0;
  var_0[1].vehicle_getoutanim = % vh_mkilo_pass_exit_patrol;
  var_0[1].vehicle_getoutanim_clear = 0;
  var_0[1].vehicle_getoutanim_combat = % vh_mkilo_pass_exit_combat_idle;
  var_0[1].vehicle_getoutanim_combat_clear = 0;
  var_0[1].vehicle_getoutanim_combat_run = % vh_mkilo_pass_exit_combat_run;
  var_0[1].vehicle_getoutanim_combat_run_clear = 0;
  return var_0;
}