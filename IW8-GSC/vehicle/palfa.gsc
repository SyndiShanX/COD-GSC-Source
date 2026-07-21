/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: vehicle\palfa.gsc
***********************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  scripts\common\vehicle_build::build_template("truck", var_0, var_1, var_2);
  scripts\common\vehicle_build::build_localinit(::init_local);
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/large_vehicle_explosion.vfx", undefined, "car_explode");
  scripts\common\vehicle_build::build_deathquake(1, 1.6, 500);
  scripts\common\vehicle_build::build_deathanimations(%veh8_common_pickup_expl_lf, %veh8_common_pickup_expl_rf, %veh8_common_pickup_expl_lb, %veh8_common_pickup_expl_rb);
  scripts\common\vehicle_build::build_radiusdamage((0, 0, 0), 500, 120, 20);
  scripts\common\vehicle_build::build_drive(%veh8_common_pickup_driving_idle_forward, %veh8_common_pickup_driving_idle_backward, 10);
  scripts\common\vehicle_build::build_treadfx(var_2, "sand", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dust.vfx");
  scripts\common\vehicle_build::build_treadfx(var_2, "dirt", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dirt.vfx");
  scripts\common\vehicle_build::build_life(1500);
  scripts\common\vehicle_build::build_team("allies");
  scripts\common\vehicle_build::build_aianims(::setanims, ::set_vehicle_anims, "palfa");
  scripts\common\vehicle_build::build_unload_groups(::unload_groups);
  scripts\common\vehicle_build::build_deathmodel(var_0, "veh8_civ_lnd_palfa_static_dst");
  scripts\common\vehicle_build::build_light(var_2, "headlight_truck_left", "tag_light_front_left", "vfx/misc/car_headlight_truck_L", "headlights");
  scripts\common\vehicle_build::build_light(var_2, "headlight_truck_right", "tag_light_front_right", "vfx/misc/car_headlight_truck_R", "headlights");
  scripts\common\vehicle_build::build_light(var_2, "brakelight_truck_right", "tag_light_back_right", "vfx/misc/car_brakelight_truck_R", "brakelights");
  scripts\common\vehicle_build::build_light(var_2, "brakelight_truck_left", "tag_light_back_left", "vfx/misc/car_brakelight_truck_L", "brakelights");
  level.g_effect["vfx_palfa_ambulance_lights"] = loadfx("vfx/iw8/level/drone/vfx_ambulance_lights.vfx");
}

init_local() {
  self.script_badplace = 1;
  self.vehicleanimalias = "palfa";
}

set_vehicle_anims(var_0) {
  var_0[0].vehicle_getoutanim = % reb_com_veh8_decho_fl_door_open;
  var_0[0].vehicle_getoutanim_clear = 0;
  var_0[1].vehicle_getoutanim = % reb_com_veh8_decho_fr_door_open;
  var_0[1].vehicle_getoutanim_clear = 0;
  return var_0;
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 2; var_1++)
    var_0[var_1] = spawnStruct();

  var_0[0].bhasgunwhileriding = 0;
  var_0[0].sittag = "TAG_DRIVER";
  var_0[1].sittag = "TAG_PASSENGER";
  var_0[0].idle = % reb_vh_palfa_driver_idle_search01;
  var_0[1].idle = % reb_vh_palfa_pass_idle_search01;
  var_0[0].death_no_ragdoll = 1;
  var_0[1].death_no_ragdoll = 1;
  return var_0;
}

unload_groups() {
  var_0 = [];
  var_0["all"] = [];
  var_0["passengers"] = [];
  var_0["default"] = [];
  var_0["all"] = [0, 1, 2, 3, 4, 5];
  var_0["passengers"] = [1, 2, 3, 4, 5];
  var_0["default"] = var_0["passengers"];
  return var_0;
}