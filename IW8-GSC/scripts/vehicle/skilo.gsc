/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\skilo.gsc
***********************************************/

#using_animtree("");

function main(var0, var1, var2) {
  scripts\common\vehicle_build::build_template("truck", var0, var1, var2);
  scripts\common\vehicle_build::build_localinit(&init_local);
  var3 = strtok(var0, "_");
  var4 = var3[var3.size - 1];

  if(var4 == "physics") {
    var4 = var3[var3.size - 2];
  }

  if(var4 == "police") {
    var5 = "veh8_civ_lnd_skilo_rus_police_static_dst";
  } else {
    var5 = "veh8_civ_lnd_skilo_static_dst";

    if(var5 != "skilo") {
      var5 += "_" + var5;
    }
  }

  scripts\common\vehicle_build::build_deathmodel(var1, var5);
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/large_vehicle_explosion.vfx", undefined, "car_explode");
  scripts\common\vehicle_build::build_deathquake(1, 1.6, 500);
  scripts\common\vehicle_build::build_radiusdamage((0, 0, 0), 500, 120, 20);
  scripts\common\vehicle_build::build_drive($veh8_common_pickup_driving_idle_forward, %veh8_common_pickup_driving_idle_backward, 10);
  scripts\common\vehicle_build::build_treadfx(var3, "sand", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dust.vfx");
  scripts\common\vehicle_build::build_treadfx(var3, "dirt", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dirt.vfx");
  scripts\common\vehicle_build::build_life(1500, 1499, 1500);
  scripts\common\vehicle_build::build_team("axis");
  scripts\common\vehicle_build::build_aianims(&setanims, &set_vehicle_anims, "skilo");
  scripts\common\vehicle_build::build_unload_groups(&unload_groups);
  scripts\common\vehicle_build::build_light(var3, "headlight_truck_left", "tag_light_front_left", "vfx/misc/car_headlight_truck_L", "headlights");
  scripts\common\vehicle_build::build_light(var3, "headlight_truck_right", "tag_light_front_right", "vfx/misc/car_headlight_truck_R", "headlights");
  scripts\common\vehicle_build::build_light(var3, "taillight_truck_right", "tag_light_back_right", "vfx/misc/car_taillight_truck_R", "headlights");
  scripts\common\vehicle_build::build_light(var3, "taillight_truck_left", "tag_light_back_left", "vfx/misc/car_taillight_truck_L", "headlights");
  scripts\common\vehicle_build::build_light(var3, "brakelight_truck_right", "tag_light_back_right", "vfx/misc/car_brakelight_truck_R", "brakelights");
  scripts\common\vehicle_build::build_light(var3, "brakelight_truck_left", "tag_light_back_left", "vfx/misc/car_brakelight_truck_L", "brakelights");
}

function init_local() {
  self.script_badplace = 1;
  self.vehicleanimalias = "skilo";
}

function setanims() {
  var0 = [];

  for(var1 = 0; var1 < 3; var1++) {
    var0 = spawnStruct();
  }

  var0[0].bhasgunwhileriding = 0;
  var0[0].sittag = "TAG_DRIVER";
  var0[1].sittag = "TAG_PASSENGER";
  var0[2].sittag = "TAG_DETACH";
  var0[0].getin = % sdr_com_veh8_techo_driver_in;
  var0[1].getin = $sdr_com_veh8_techo_passenger_in;
  var0[2].getin = % sdr_com_veh8_techo_back_1_in;
  var0[0].idle = % reb_vh_skilo_driver_idle_search01;
  var0[1].idle = % reb_vh_skilo_passenger_idle_search01;
  var0[2].idle = % reb_vh_skilo_pass3_idle_search01;
  var0[0].getout = % reb_vh_skilo_driver_exit_combat_idle;
  var0[1].getout = % reb_vh_skilo_passenger_exit_combat_idle;
  var0[2].getout = % reb_vh_skilo_pass3_exit_combat_idle;
  var0[0].death = % emb_def_truck_driver_death;
  var0[1].death = % emb_def_truck_driver_death;
  var0[2].death = % emb_def_truck_driver_death;
  var0[0].death_no_ragdoll = 1;
  var0[1].death_no_ragdoll = 1;
  var0[2].death_no_ragdoll = 1;
  return var0;
}

function unload_groups() {
  var0 = [];

  for(var1 = 0; var1 < 3; var1++) {
    var0[var1] = var1;
  }

  return var0;
}

function set_vehicle_anims(var0) {
  var0[0].vehicle_getoutanim = % vh_skilo_driver_exit_patrol;
  var0[0].vehicle_getoutanim_clear = 0;
  var0[0].vehicle_getoutanim_combat = $vh_skilo_driver_exit_combat_idle;
  var0[0].vehicle_getoutanim_combat_clear = 0;
  var0[0].vehicle_getoutanim_combat_run = % vh_skilo_driver_exit_combat_run;
  var0[0].vehicle_getoutanim_combat_run_clear = 0;
  var0[1].vehicle_getoutanim = % vh_skilo_passenger_exit_patrol;
  var0[1].vehicle_getoutanim_clear = 0;
  var0[1].vehicle_getoutanim_combat = % vh_skilo_passenger_exit_combat_idle;
  var0[1].vehicle_getoutanim_combat_clear = 0;
  var0[1].vehicle_getoutanim_combat_run = % vh_skilo_passenger_exit_combat_run;
  var0[1].vehicle_getoutanim_combat_run_clear = 0;
  var0[2].vehicle_getoutanim = % vh_skilo_pass3_exit_patrol;
  var0[2].vehicle_getoutanim_clear = 0;
  var0[2].vehicle_getoutanim_combat = % vh_skilo_pass3_exit_combat_idle;
  var0[2].vehicle_getoutanim_combat_clear = 0;
  var0[2].vehicle_getoutanim_combat_run = % vh_skilo_pass3_exit_combat_run;
  var0[2].vehicle_getoutanim_combat_run_clear = 0;
  return var0;
}