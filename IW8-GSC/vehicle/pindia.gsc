/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: vehicle\pindia.gsc
***********************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  scripts\common\vehicle_build::build_template("truck", var_0, var_1, var_2);
  scripts\common\vehicle_build::build_localinit(::init_local);

  if(isendstr(var_2, "_physics"))
    scripts\common\vehicle_build::build_deathmodel(var_0, "veh8_mil_lnd_pindia_static_dst_physics");
  else
    scripts\common\vehicle_build::build_deathmodel(var_0, "veh8_mil_lnd_pindia_static_dst");

  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/large_vehicle_explosion.vfx", undefined, "veh_gen_mtl_expl_small");
  scripts\common\vehicle_build::build_deathquake(1, 1.6, 500);
  scripts\common\vehicle_build::build_deathanimations(%veh8_common_pickup_expl_lf, %veh8_common_pickup_expl_rf, %veh8_common_pickup_expl_lb, %veh8_common_pickup_expl_rb);
  scripts\common\vehicle_build::build_radiusdamage((0, 0, 0), 500, 120, 20);
  scripts\common\vehicle_build::build_drive(%veh8_common_pickup_driving_idle_forward, %veh8_common_pickup_driving_idle_backward, 10);
  scripts\common\vehicle_build::build_treadfx(var_2, "sand", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dust.vfx");
  scripts\common\vehicle_build::build_treadfx(var_2, "dirt", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dirt.vfx");
  scripts\common\vehicle_build::build_life(1500, 1499, 1500);
  scripts\common\vehicle_build::build_team("axis");
  scripts\common\vehicle_build::build_aianims(::setanims, ::set_vehicle_anims);
  scripts\common\vehicle_build::build_unload_groups(::unload_groups);
  scripts\common\vehicle_build::build_light(var_2, "headlight_truck_left", "tag_light_front_left", "vfx/iw8/veh/system/vfx_veh_sys_headlight_pindia_left", "headlights");
  scripts\common\vehicle_build::build_light(var_2, "headlight_truck_right", "tag_light_front_right", "vfx/iw8/veh/system/vfx_veh_sys_headlight_pindia_right", "headlights");
}

init_local() {
  self.script_badplace = 1;
  self.vehicleanimalias = "pindia";
  self.vehicledisableturningwhileshooting = 1;
}

set_vehicle_anims(var_0) {
  return var_0;
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 6; var_1++)
    var_0[var_1] = spawnStruct();

  var_0[0].canshootinvehicle = 0;
  var_0[1].canshootinvehicle = 0;
  var_0[2].canshootinvehicle = 1;
  var_0[3].canshootinvehicle = 1;
  var_0[4].canshootinvehicle = 1;
  var_0[5].canshootinvehicle = 1;
  var_0[0].sittag = "TAG_DRIVER";
  var_0[1].sittag = "TAG_PASSENGER";
  var_0[2].sittag = "TAG_BED_GUY1";
  var_0[3].sittag = "TAG_BED_GUY2";
  var_0[4].sittag = "TAG_BED_GUY3";
  var_0[5].sittag = "TAG_BED_GUY4";
  var_0[0].getin = % reb_vh_pindia_driver_get_in;
  var_0[1].getin = % reb_vh_pindia_pass_get_in;
  var_0[2].getin = % sdr_com_veh8_techo_back_1_in;
  var_0[3].getin = % sdr_com_veh8_techo_back_2_in;
  var_0[4].getin = % sdr_com_veh8_pindia_driver_in;
  var_0[5].getin = % sdr_com_veh8_pindia_passenger_in;
  var_0[0].idle = % reb_vh_pindia_driver_idle_search01;
  var_0[1].idle = % reb_vh_pindia_pass_idle_search01;
  var_0[2].idle = % reb_vh_pindia_bed_guy1_idle_search01;
  var_0[3].idle = % reb_vh_pindia_bed_guy2_idle_search01;
  var_0[4].idle = % reb_vh_pindia_bed_guy3_idle_search01;
  var_0[5].idle = % reb_vh_pindia_bed_guy4_idle_search01;
  var_0[0].getout = % reb_vh_pindia_driver_exit_patrol;
  var_0[1].getout = % reb_vh_pindia_pass_exit_patrol;
  var_0[2].getout = % reb_vh_pindia_bed_guy1_exit_patrol;
  var_0[3].getout = % reb_vh_pindia_bed_guy2_exit_patrol;
  var_0[4].getout = % reb_vh_pindia_bed_guy3_exit_patrol;
  var_0[5].getout = % reb_vh_pindia_bed_guy4_exit_patrol;
  var_0[0].death = % reb_vh_pindia_driver_death01;
  var_0[1].death = % reb_vh_pindia_pass_death01;
  var_0[2].death = % reb_vh_pindia_bed_guy_death01;
  var_0[3].death = % reb_vh_pindia_bed_guy_death01;
  var_0[4].death = % reb_vh_pindia_bed_guy_death01;
  var_0[5].death = % reb_vh_pindia_bed_guy_death01;
  var_0[0].death_no_ragdoll = 1;
  var_0[1].death_no_ragdoll = 1;
  var_0[2].death_no_ragdoll = 1;
  var_0[3].death_no_ragdoll = 1;
  var_0[4].death_no_ragdoll = 1;
  var_0[5].death_no_ragdoll = 1;

  if(isDefined(level.pindia_positions_override_func))
    var_0 = [[level.pindia_positions_override_func]](var_0);

  return var_0;
}

unload_groups() {
  var_0 = [];

  for(var_1 = 0; var_1 < 6; var_1++)
    var_0["default"][var_1] = var_1;

  return var_0;
}