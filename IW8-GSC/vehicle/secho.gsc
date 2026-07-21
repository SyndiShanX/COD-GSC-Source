/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: vehicle\secho.gsc
***********************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  scripts\common\vehicle_build::build_template("secho", var_0, var_1, var_2);
  scripts\common\vehicle_build::build_localinit(::init_local);
  scripts\common\vehicle_build::build_deathmodel(var_0, "veh8_civ_lnd_secho_static_dst");
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/large_vehicle_explosion.vfx", undefined, "car_explode");
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
  scripts\common\vehicle_build::build_light(var_2, "headlight_truck_left", "tag_light_front_left", "vfx/misc/car_headlight_truck_L", "headlights");
  scripts\common\vehicle_build::build_light(var_2, "headlight_truck_right", "tag_light_front_right", "vfx/misc/car_headlight_truck_R", "headlights");
  scripts\common\vehicle_build::build_light(var_2, "taillight_truck_right", "tag_light_back_right", "vfx/misc/car_taillight_truck_R", "headlights");
  scripts\common\vehicle_build::build_light(var_2, "taillight_truck_left", "tag_light_back_left", "vfx/misc/car_taillight_truck_L", "headlights");
  scripts\common\vehicle_build::build_light(var_2, "brakelight_truck_right", "tag_light_back_right", "vfx/misc/car_brakelight_truck_R", "brakelights");
  scripts\common\vehicle_build::build_light(var_2, "brakelight_truck_left", "tag_light_back_left", "vfx/misc/car_brakelight_truck_L", "brakelights");
}

init_local() {
  self.script_badplace = 1;
  self.vehicleanimalias = "techo";
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 3; var_1++)
    var_0[var_1] = spawnStruct();

  var_0[0].bhasgunwhileriding = 0;
  var_0[0].sittag = "TAG_DRIVER";
  var_0[1].sittag = "TAG_PASSENGER";
  var_0[2].sittag = "TAG_DETACH";
  var_0[0].getin = % sdr_com_veh8_techo_driver_in;
  var_0[1].getin = % sdr_com_veh8_techo_passenger_in;
  var_0[2].getin = % sdr_com_veh8_techo_back_1_in;
  var_0[0].idle = % sdr_com_veh8_techo_driver_idle;
  var_0[1].idle = % sdr_com_veh8_techo_passenger_idle;
  var_0[2].idle = % sdr_com_veh8_techo_back_1_idle;
  var_0[0].getout = % sdr_com_veh8_techo_driver_out;
  var_0[1].getout = % sdr_com_veh8_techo_passenger_out;
  var_0[2].getout = % sdr_com_veh8_techo_back_1_out;
  var_0[0].death = % emb_def_truck_driver_death;
  var_0[1].death = % emb_def_truck_driver_death;
  var_0[2].death = % emb_def_truck_driver_death;
  var_0[0].death_no_ragdoll = 1;
  return var_0;
}

unload_groups() {
  var_0 = [];

  for(var_1 = 0; var_1 < 3; var_1++)
    var_0["default"][var_1] = var_1;

  return var_0;
}

#using_animtree("vehicles");

set_vehicle_anims(var_0) {
  var_0[0].vehicle_getoutanim = % reb_com_veh8_techo_fl_door_open;
  var_0[0].vehicle_getoutanim_clear = 0;
  var_0[1].vehicle_getoutanim = % reb_com_veh8_techo_fr_door_open;
  var_0[1].vehicle_getoutanim_clear = 0;
  var_0[2].vehicle_getoutanim = % reb_com_veh8_techo_br_door_open;
  var_0[2].vehicle_getoutanim_clear = 0;
  var_0[0].vehicle_getinanim = % reb_com_veh8_techo_fl_door_close;
  var_0[0].vehicle_getinanim_clear = 0;
  var_0[1].vehicle_getinanim = % reb_com_veh8_techo_fr_door_close;
  var_0[1].vehicle_getinanim_clear = 0;
  var_0[2].vehicle_getinanim = % reb_com_veh8_techo_br_door_close;
  var_0[2].vehicle_getinanim_clear = 0;
  return var_0;
}