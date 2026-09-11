/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\walfa.gsc
***********************************************/

#using_animtree("");

function main(var0, var1, var2) {
  scripts\common\vehicle_build::build_template("truck", var0, var1, var2);
  scripts\common\vehicle_build::build_localinit(&init_local);
  var3 = "veh8_civ_lnd_walfa_static_dst";
  var4 = strtok(var2, "_");
  var5 = var4[var4.size - 1];

  if(var5 == "physics") {
    var5 = var4[var4.size - 2];
  }

  if(var5 != "white") {
    var3 += "_" + var5;
  }

  scripts\common\vehicle_build::build_deathmodel(var0, var3);
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/large_vehicle_explosion.vfx", undefined, "car_explode");
  scripts\common\vehicle_build::build_deathquake(1, 1.6, 500);
  scripts\common\vehicle_build::build_deathanimations(%veh8_common_pickup_expl_lf, %veh8_common_pickup_expl_rf, $veh8_common_pickup_expl_lb, %veh8_common_pickup_expl_rb);
  scripts\common\vehicle_build::build_radiusdamage((0, 0, 0), 500, 120, 20);
  scripts\common\vehicle_build::build_drive(%veh8_common_pickup_driving_idle_forward, %veh8_common_pickup_driving_idle_backward, 10);
  scripts\common\vehicle_build::build_treadfx(var2, "sand", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dust.vfx");
  scripts\common\vehicle_build::build_treadfx(var2, "dirt", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dirt.vfx");
  scripts\common\vehicle_build::build_life(1500, 1499, 1500);
  scripts\common\vehicle_build::build_team("allies");
  scripts\common\vehicle_build::build_light(var2, "headlight_truck_left", "tag_light_front_left", "vfx/misc/car_headlight_truck_L", "headlights");
  scripts\common\vehicle_build::build_light(var2, "headlight_truck_right", "tag_light_front_right", "vfx/misc/car_headlight_truck_R", "headlights");
  scripts\common\vehicle_build::build_light(var2, "taillight_truck_right", "tag_light_back_right", "vfx/misc/car_taillight_truck_R", "headlights");
  scripts\common\vehicle_build::build_light(var2, "taillight_truck_left", "tag_light_back_left", "vfx/misc/car_taillight_truck_L", "headlights");
  scripts\common\vehicle_build::build_light(var2, "brakelight_truck_right", "tag_light_back_right", "vfx/misc/car_brakelight_truck_R", "brakelights");
  scripts\common\vehicle_build::build_light(var2, "brakelight_truck_left", "tag_light_back_left", "vfx/misc/car_brakelight_truck_L", "brakelights");
}

function init_local() {
  self.script_badplace = 1;
  self.vehicleanimalias = "walfa";
}

function setanims() {
  var0 = [];

  for(var1 = 0; var1 < 1; var1++) {
    var0 = spawnStruct();
  }

  var0[0].bhasgunwhileriding = 0;
  var0[0].sittag = "TAG_DRIVER";
  var0[0].canshootinvehicle = 0;
  var0[0].getin = % sdr_com_veh8_techo_driver_in;
  var0[0].idle_anim = "sdr_com_veh8_techo_driver_idle";
  var0[0].idle = $sdr_com_veh8_techo_driver_idle;
  var0[0].getout = % sdr_com_veh8_techo_driver_out;
  var0[0].death = % emb_def_truck_driver_death;
  var0[0].death_no_ragdoll = 1;
  return var0;
}

function set_vehicle_anims(var0) {
  return var0;
}