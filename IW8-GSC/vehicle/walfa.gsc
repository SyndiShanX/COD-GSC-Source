/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: vehicle\walfa.gsc
***********************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  scripts\common\vehicle_build::build_template("truck", var_0, var_1, var_2);
  scripts\common\vehicle_build::build_localinit(::init_local);
  var_3 = "veh8_civ_lnd_walfa_static_dst";
  var_4 = strtok(var_2, "_");
  var_5 = var_4[var_4.size - 1];

  if(var_5 == "physics")
    var_5 = var_4[var_4.size - 2];

  if(var_5 != "white")
    var_3 = var_3 + ("_" + var_5);

  scripts\common\vehicle_build::build_deathmodel(var_0, var_3);
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/large_vehicle_explosion.vfx", undefined, "car_explode");
  scripts\common\vehicle_build::build_deathquake(1, 1.6, 500);
  scripts\common\vehicle_build::build_deathanimations(%veh8_common_pickup_expl_lf, %veh8_common_pickup_expl_rf, %veh8_common_pickup_expl_lb, %veh8_common_pickup_expl_rb);
  scripts\common\vehicle_build::build_radiusdamage((0, 0, 0), 500, 120, 20);
  scripts\common\vehicle_build::build_drive(%veh8_common_pickup_driving_idle_forward, %veh8_common_pickup_driving_idle_backward, 10);
  scripts\common\vehicle_build::build_treadfx(var_2, "sand", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dust.vfx");
  scripts\common\vehicle_build::build_treadfx(var_2, "dirt", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dirt.vfx");
  scripts\common\vehicle_build::build_life(1500, 1499, 1500);
  scripts\common\vehicle_build::build_team("allies");
  scripts\common\vehicle_build::build_light(var_2, "headlight_truck_left", "tag_light_front_left", "vfx/misc/car_headlight_truck_L", "headlights");
  scripts\common\vehicle_build::build_light(var_2, "headlight_truck_right", "tag_light_front_right", "vfx/misc/car_headlight_truck_R", "headlights");
  scripts\common\vehicle_build::build_light(var_2, "taillight_truck_right", "tag_light_back_right", "vfx/misc/car_taillight_truck_R", "headlights");
  scripts\common\vehicle_build::build_light(var_2, "taillight_truck_left", "tag_light_back_left", "vfx/misc/car_taillight_truck_L", "headlights");
  scripts\common\vehicle_build::build_light(var_2, "brakelight_truck_right", "tag_light_back_right", "vfx/misc/car_brakelight_truck_R", "brakelights");
  scripts\common\vehicle_build::build_light(var_2, "brakelight_truck_left", "tag_light_back_left", "vfx/misc/car_brakelight_truck_L", "brakelights");
}

init_local() {
  self.script_badplace = 1;
  self.vehicleanimalias = "walfa";
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 1; var_1++)
    var_0[var_1] = spawnStruct();

  var_0[0].bhasgunwhileriding = 0;
  var_0[0].sittag = "TAG_DRIVER";
  var_0[0].canshootinvehicle = 0;
  var_0[0].getin = % sdr_com_veh8_techo_driver_in;
  var_0[0].idle_anim = "sdr_com_veh8_techo_driver_idle";
  var_0[0].idle = % sdr_com_veh8_techo_driver_idle;
  var_0[0].getout = % sdr_com_veh8_techo_driver_out;
  var_0[0].death = % emb_def_truck_driver_death;
  var_0[0].death_no_ragdoll = 1;
  return var_0;
}

set_vehicle_anims(var_0) {
  return var_0;
}